import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:database/dao/multi_media/i_multimedia_dao.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:download_manager/data/download_manager_task.dart';
import 'package:download_manager/data/download_status.dart';
import 'package:download_manager/data/download_status_info.dart';
import 'package:download_manager/i_download_manager.dart';
import 'package:download_manager/model_mapper/download_manager_task_mapper.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:core/utils/extensions/string_extensions.dart';

import 'data/download_request.dart';
import 'exceptions.dart';

class _Constants {
  static const String taskByIdQuery = "SELECT * FROM task WHERE task_id=";
  static const String taskByStatusQuery = "SELECT * FROM task WHERE status=";
}

class DownloadManager implements IDownloadManager {
  late String _localPath;
  late bool _permissionReady;
  static final _streamController = StreamController<DownloadStatusInfo>();
  final ReceivePort _port = ReceivePort();
  final IMultimediaDao multimediaDao;

  DownloadManager({required this.multimediaDao});

  @override
  void init() async {
    await FlutterDownloader.initialize(
        debug: true,
        // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
    _bindBackgroundIsolate();
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) async {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as int;
      final progress = data[2] as int;
      _onDownloadUpdate(taskId, progress, status.enm);
      _streamController.add(DownloadStatusInfo(
          taskId: taskId, progress: progress, status: status.enm));
    });

    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  void _onDownloadUpdate(
      String taskId, int progress, DownloadStatus status) async {
    await multimediaDao.updateMultimediaDownloadStatusWithProgress(
        taskId, progress, status.enmDb);
  }

  ///Before enqueue any request, Use this method to check that storage permission is granted or not.
  ///[PermissionNotGrantedException] will be thrown if the storage permission is not granted and request is tried to enqueue.
  @override
  Future<bool> isStoragePermissionGranted() async {
    await _checkPermissionAndPrepareStorage();
    return Future.value(_permissionReady);
  }

  @override
  Future<String?> enqueue(DownloadRequest request) async {
    if (!await isStoragePermissionGranted()) {
      throw PermissionNotGrantedException(
          message: "Permission for storage is not granted!");
    }

    final taskId = await FlutterDownloader.enqueue(
      url: request.url,
      fileName: request.fileName.convertToMD5(),
      headers: request.headers,
      // optional: header send with url (auth token etc)
      savedDir: _localPath,
      showNotification: request.showNotification,
      // show download progress in status bar (for Android)
      openFileFromNotification: request.openFileFromNotification,
      // click on notification to open downloaded file (for Android)
      requiresStorageNotLow: request.requiresStorageNotLow,
      saveInPublicStorage: request.saveInPublicStorage,
      allowCellular: request.allowCellular,
      timeout: request.timeout,
    );
    return taskId;
  }

  @override
  Future<List<String?>> enqueueMultiple(List<DownloadRequest> requests) async {
    if (!await isStoragePermissionGranted()) {
      throw PermissionNotGrantedException(
          message: "Permission for storage is not granted!");
    }
    List<String?> taskList = [];
    for (var request in requests) {
      final taskId = await FlutterDownloader.enqueue(
        url: request.url,
        fileName: request.fileName.convertToMD5(),
        headers: request.headers,
        // optional: header send with url (auth token etc)
        savedDir: _localPath,
        showNotification: request.showNotification,
        // show download progress in status bar (for Android)
        openFileFromNotification: request.openFileFromNotification,
        // click on notification to open downloaded file (for Android)
        requiresStorageNotLow: request.requiresStorageNotLow,
        saveInPublicStorage: request.saveInPublicStorage,
        allowCellular: request.allowCellular,
        timeout: request.timeout,
      );
      taskList.add(taskId);
    }
    return Future.value(taskList);
  }

  @override
  Future<void> pauseDownload(String taskId) async {
    if (taskId.isEmpty) {
      return;
    }
    await FlutterDownloader.pause(taskId: taskId);
  }

  @override
  Future<String> resumeDownload(String taskId) async {
    final id = await FlutterDownloader.resume(taskId: taskId);
    return Future.value(id);
  }

  @override
  Future<String> retryDownload(String taskId) async {
    final newTaskId = await FlutterDownloader.retry(taskId: taskId);
    return Future.value(newTaskId);
  }

  @override
  Future<bool> openDownloadedFile(String taskId) async {
    if (taskId.isEmpty) {
      return false;
    }
    return FlutterDownloader.open(taskId: taskId);
  }

  @override
  Future<void> delete(String taskId) async {
    if (taskId.isEmpty) {
      return;
    }
    await FlutterDownloader.remove(
      taskId: taskId,
      shouldDeleteContent: true,
    );
  }

  @override
  Future<void> cancel(String taskId) async {
    if (taskId.isEmpty) {
      return;
    }
    await FlutterDownloader.cancel(
      taskId: taskId,
    );
  }

  @override
  Future<void> cancelAll() async {
    await FlutterDownloader.cancelAll();
  }

  @override
  Future<List<DownloadManagerTask>?> getAllTask(String taskId) async {
    final taskList = await FlutterDownloader.loadTasks();
    return taskList?.map((e) => DownloadManagerTaskMapper.fromDownloadTask(e))
        as List<DownloadManagerTask>;
  }

  @override
  Future<List<DownloadManagerTask>?> getTaskByStatus(
      DownloadStatus status) async {
    final result = await FlutterDownloader.loadTasksWithRawQuery(
        query: "${_Constants.taskByStatusQuery}${status.index}");
    if (result == null || result.isEmpty) {
      return null;
    }
    return result.map((e) => DownloadManagerTaskMapper.fromDownloadTask(e))
        as List<DownloadManagerTask>;
  }

  @override
  Future<DownloadManagerTask?> getTaskById(String taskId) async {
    final result = await FlutterDownloader.loadTasksWithRawQuery(
        query: "${_Constants.taskByIdQuery}\"$taskId\"");
    if (result == null || result.isEmpty) {
      return null;
    }
    return Future.value(DownloadManagerTaskMapper.fromDownloadTask(result.first));
  }

  Future<void> _checkPermissionAndPrepareStorage() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }
    _permissionReady = hasGranted;
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;
    return externalStorageDirPath;
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String taskId,
    int status,
    int progress,
  ) {
    // print(
    //   'Download Status: '
    //   'task ($taskId) is in status ($status) and process ($progress)',
    // );
    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([taskId, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  Stream<DownloadStatusInfo> subscribeForUpdate() {
    return _streamController.stream;
  }

  @override
  void cleanup() {
    _unbindBackgroundIsolate();
    _streamController.close();
  }

}
