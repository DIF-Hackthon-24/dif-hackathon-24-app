import 'package:core/device_info/device_full_detail.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/session_management/inactivity_service.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:network_manager/utils/connectivity/jwt_parser.dart';
import 'package:task_manager/session_management/token_refresh_service/data/token_refresh_service.dart';
import 'package:task_manager/session_management/token_refresh_service/service_dependencies/data_model/token_refresh_response_model.dart';
import 'package:task_manager/task_manager.dart';
import 'package:task_manager/uuid/uuid_data_provider.dart';
import 'package:task_manager/uuid/uuid_manager.dart';
import 'package:uuid/uuid.dart';

class TokenRefreshUseCase {
  final TaskManager _taskManager;
  TokenRefreshUseCase(this._taskManager);

  Future refreshToken() async {
    final deviceId = await DeviceInfo.getDeviceId();
    final traceId = await UUIDDataProviderImpl(
      taskManager: _taskManager,
      uuidManager: UUIDManagerImpl(
        uuidClient: const Uuid(),
      ),
    ).getUuidFromSecureStorage();
    String? newToken;
    newToken = await DIContainer.container.resolve<IAuthManager>().getAccessToken();

    final result = await _taskManager.waitForExecute<TokenRefreshResponseModel?>(
      Task(
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: TokenRefreshService.identifier,
        parameters: TokenRefreshServiceParams(
          deviceId: deviceId,
          token: newToken,
          traceId: traceId,
        ),
      ),
    ) as TokenRefreshResponseModel?;

    if (result?.headers != null) {
      DIContainer.container.resolve<IAuthManager>().storeTokenInformation(
            accessToken: result?.headers?['x-oss-token'] as String,
            sessionId: '',
            individualId: '',
          );
      final inactivityService = DIContainer.container.resolve<IInactivityService>();
      inactivityService.startTimer(expiryTime: Jwt.getExpiryDate(result?.headers?['x-oss-token'] as String));
    }
  }
}
