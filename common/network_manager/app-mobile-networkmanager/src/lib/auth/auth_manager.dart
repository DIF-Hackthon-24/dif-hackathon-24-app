// Package imports:
import 'package:core/logging/logger.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
// import 'package:core/storage/secure_storage/secure_storage_service.dart';

// Project imports:
import 'package:network_manager/auth/i_auth_manager.dart';

class AuthManager implements IAuthManager {

  // the expiry buffer is to mitigate latency from the connection between client and server.
  // when a token is generated so is its expiry time in seconds.
  // static const _expiryBuffer = 30;

  String? _accessToken;

  //final SecureStorageService _secureStorageService;

  String? _individualId;
  String? _sessionId;

  //AuthManager(this._secureStorageService);
  AuthManager();

  @override
  String sessionId() {
    return _sessionId ?? _individualId ?? '';
  }

  @override
  Future<String?> getAccessToken() async {
    PSLogger.logInfo('Attempting to retrieve access token');
    //AuthManager should not be responsible for refreshing,or should it be?
    //if is responsible then AuthManager has dependency on TaskManager
    //and TaskManager has dependency on AuthManager via NetworkClient
    // final expiryDateTime = await getExpireTime();
    // if (DateTime.now().toUtc().isAfter(expiryDateTime!)) {
    //   await _refreshAccessToken();
    // }
    return _accessToken;
  }

  @override
  Future<bool> isUserAuthenticated() async => _accessToken != null && _accessToken!.isNotEmpty;

  void _setAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  void _setIndividualId(String individualId) {
    _individualId = individualId;
  }

  ///Clear everything except refreshToken which we need for biometrics login
  @override
  Future<void> clearState() async {
    _sessionId = '';
    PerformanceMonitor.updateUserDetails('', '');
    _setAccessToken('');
    _setIndividualId('');
  }

  @override
  Future storeTokenInformation({
    required String accessToken,
    required String sessionId,
    required String individualId,
  }) async {
    _sessionId = sessionId;
    PerformanceMonitor.updateUserDetails(sessionId, individualId);
    _setAccessToken(accessToken);
    _setIndividualId(individualId);
  }
}
