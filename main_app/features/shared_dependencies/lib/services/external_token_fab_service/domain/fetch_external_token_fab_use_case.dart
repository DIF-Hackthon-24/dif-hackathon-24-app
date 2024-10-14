// ignore_for_file: unused_field

import 'package:shared_dependencies/base_usecase/base_usecase.dart';
import 'package:shared_dependencies/services/external_token_fab_service/service_dependancies/data_model/fetch_external_token_fab_response_model.dart';
import 'package:task_manager/task_manager_impl/task_manager_impl.dart';

abstract class IOssTokenForFabUseCase {
  Future<OssTokenForFabResponseModel?> fetchOssTokenForFab();
}

class OssTokenForFabUseCase extends BaseUseCase
    implements IOssTokenForFabUseCase {
  late TaskManager _taskManager;

  OssTokenForFabUseCase(
    TaskManager taskManager,
  ) : super(taskManager) {
    this._taskManager = taskManager;
  }

  @override
  Future<OssTokenForFabResponseModel?> fetchOssTokenForFab() async {
    /* String authToken = "";
    await getToken().then((value) {
      authToken = value;
    });

    final deviceId = await DeviceInfo.getDeviceId();
    final traceId = await UUIDDataProviderImpl(
      taskManager: _taskManager,
      uuidManager: UUIDManagerImpl(
        uuidClient: const Uuid(),
      ),
    ).getUuidFromSecureStorage();


    return await executeApiAndHandleErrors<OssTokenForFabResponseModel?>(
      task: Task(
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: OssTokenForFabService.identifier,
        parameters: OssTokenForFabServiceParams(
          deviceId: deviceId,
          token: authToken,
          traceId: traceId,
        ),
      ),
    ); */
    return null;
  }


}
