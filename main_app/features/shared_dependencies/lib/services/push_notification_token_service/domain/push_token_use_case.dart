// ignore_for_file: unused_field

import 'dart:io';

import 'package:shared_dependencies/base_usecase/base_usecase.dart';
import 'package:shared_dependencies/constants/string_constants.dart';
import 'package:task_manager/task_manager_impl/task_manager_impl.dart';

abstract class IPushRegistrationTokenToNotificationHubUseCase {
  void sendTokenToNotificationHub(String? deviceToken, String languageCode);
}

class PushRegistrationTokenToNotificationHubUseCase extends BaseUseCase
    implements IPushRegistrationTokenToNotificationHubUseCase {
  late TaskManager _taskManager;

  PushRegistrationTokenToNotificationHubUseCase(TaskManager taskManager) : super(taskManager) {
    this._taskManager = taskManager;
  }

  @override
  void sendTokenToNotificationHub(String? deviceToken, String languageCode) async {
    return null;
    /* String authToken = "";
    await getToken().then((value) {
      authToken = value;
    });

    String platform = getPlatform();
    final deviceId = await DeviceInfo.getDeviceId();
    final traceId = await UUIDDataProviderImpl(
      taskManager: _taskManager,
      uuidManager: UUIDManagerImpl(
        uuidClient: const Uuid(),
      ),
    ).getUuidFromSecureStorage();

    await executeApiAndHandleErrors<PushRegistrationTokenToNotificationHubResponseModel?>(
      task: Task(
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: PushRegistrationTokenToNotificationHubService.identifier,
        parameters: PushRegistrationTokenToNotificationHubServiceParams(
          deviceId: deviceId,
          token: authToken,
          traceId: traceId,
          pushRegistrationToken: deviceToken,
          platform: platform,
          language_pref: languageCode,
        ),
      ),
    ); */
  }

  String getPlatform() {
    return Platform.isAndroid
        ? StringConstants.androidParamForNotificationHub
        : StringConstants.iosParamForNotificationHub;
  }
}
