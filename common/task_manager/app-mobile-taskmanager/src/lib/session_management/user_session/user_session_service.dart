import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/task/i_task.dart';
import 'package:core/task/task_params.dart';
import 'package:core/translation/i_app_localization_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:task_manager/session_management/session_timeout_manager.dart';
import 'package:task_manager/session_management/user_session/user_session_service_params.dart';
// import 'package:task_manager/task_manager.dart';

class _Constants {
  // static const keyShowLoginScreen = 'showLoginScreen';
  // static const screenIntro = 'login-intro';
  static const screenLogin = 'login-login';
}

class UserSessionService implements ITask {
  static const identifier = 'user_session';

  @override
  Future<dynamic> waitOnTask<T>(TaskParams? parameters) async {
    final params = parameters as UserSessionServiceParams;

    switch (params.type) {
      case UserSessionServiceType.start:
        _startUserSession(params.sessionTimeout!);
        return Future.value(true);

      case UserSessionServiceType.end:
        await _endUserSession(params.showTimeoutMessage ?? true, params.requestData);
        return Future.value(true);
    }
  }

  void _startUserSession(int sessionDuration) {
    final sessionTimeoutManager = DIContainer.container<SessionTimeoutManager>();
    sessionTimeoutManager.initNewSession(sessionDuration);
  }

  Future _endUserSession(
    bool showTimeoutMessage,
    Map<String, dynamic>? parameters,
  ) async {
    // Perform a 'logout'

    //var taskManager = DIContainer.container<TaskManager>();
    var localization = DIContainer.container<IAppLocalizationService>();

    ///Clear everything except refreshToken, which we need for biometrics login
    DIContainer.container<IAuthManager>().clearState();

    if (showTimeoutMessage) {
      await Fluttertoast.showToast(
        msg: localization.getValue('user_session_timeout_msg'),
        gravity: ToastGravity.SNACKBAR,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    await NavigationManager.navigateTo(
      _nextScreen(parameters),
      NavigationType.Replace,
    );

    PSLogger.logInfo(
      'Logging user out as session timed out.',
    );
  }

  String _nextScreen(Map<String, dynamic>? requestData) {
    return _Constants.screenLogin;
  }
}
