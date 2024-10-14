import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/model/requests/rest/file_upload_request.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/file_upload/file_upload_task_params.dart';
import 'package:task_manager/task_manager.dart';

extension TaskManagerDataRequestFileUploadTaskHandler on TaskManager {
  Future handleRestFileUploadTask(Task task) async {
    try {
      final client = DIContainer.container<INetworkClient>(
        NetworkManager.networkClientKey,
      );

      final params = task.parameters as FileUploadTaskParams;
      final headers = params.headers;
      final parameters = params.parameters;
      final request = FileUploadRequest(
          name: params.name,
          file: params.file,
          additionalHeaders: headers,
          variables: parameters,
          requestFields: params.requestFields,
          responseModel: params.responseDataModel,
          urlValues: params.urlValues
      );
      return client.runFileUpload(request: request);
    } catch (error, stacktrace) {
      PSLogger.logError('Failed to upload file with error: ${error.toString()}');
      PSLogger.logError('Stacktrace: ${stacktrace.toString()}');
    }
  }
}
