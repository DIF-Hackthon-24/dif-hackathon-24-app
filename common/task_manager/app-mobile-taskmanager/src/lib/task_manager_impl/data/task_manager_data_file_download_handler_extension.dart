import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/file_download/file_download_task_params.dart';
import 'package:task_manager/task_manager.dart';

extension TaskManagerFileDownloadTaskHandler on TaskManager {
  Future handleFileDownloadTask(Task task) async {
    try {
      final client = DIContainer.container<INetworkClient>(
        NetworkManager.networkClientKey,
      );

      final params = task.parameters as FileDownloadTaskParams;
      final url = params.url;
      final savePath = params.savePath;
      final queryParams = params.queryParams;
      final headers = params.headers;
      return client.downloadFileFromUrl(url, savePath,queryParams: queryParams ?? {},headers: headers ?? {});
    } catch (error, stacktrace) {
      PSLogger.logError('Failed to upload file with error: ${error.toString()}');
      PSLogger.logError('Stacktrace: ${stacktrace.toString()}');
    }
  }
}
