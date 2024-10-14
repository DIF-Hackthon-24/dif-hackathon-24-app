import 'package:download_manager/data/download_request.dart';
import 'package:download_manager/data/download_status.dart';
import 'package:download_manager/data/download_status_info.dart';
import 'package:download_manager/data/download_manager_task.dart';

abstract class IDownloadManager {
  void init();

  void cleanup();

  Stream<DownloadStatusInfo> subscribeForUpdate();

  Future<bool> isStoragePermissionGranted();

  Future<String?> enqueue(DownloadRequest request);

  Future<List<String?>> enqueueMultiple(
      List<DownloadRequest> requests);

  Future<void> pauseDownload(String taskId);

  Future<String> resumeDownload(String taskId);

  Future<String> retryDownload(String task);

  Future<bool> openDownloadedFile(String taskId);

  Future<void> delete(String taskId);

  Future<void> cancel(String taskId);

  Future<void> cancelAll();

  Future<List<DownloadManagerTask>?> getAllTask(String taskId);

  Future<List<DownloadManagerTask>?> getTaskByStatus(DownloadStatus status);

  Future<DownloadManagerTask?> getTaskById(String taskId);
}
