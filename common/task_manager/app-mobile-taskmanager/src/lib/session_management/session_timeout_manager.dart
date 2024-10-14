import 'dart:async';

import 'package:core/translation/i_app_localization_service.dart';
import 'package:task_manager/session_management/user_session/user_session_service.dart';
import 'package:task_manager/session_management/user_session/user_session_service_params.dart';
import 'package:task_manager/task_manager.dart';

class SessionTimeoutManager {
  final TaskManager taskManager;
  final IAppLocalizationService localization;
  static Timer? _timer;

  SessionTimeoutManager({required this.taskManager, required this.localization});

  void initNewSession(int sessionDuration) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(minutes: sessionDuration), () {
      _timedOut();
    });
  }

  Future _timedOut() async {
    var newUserSessionTask = Task(
      taskType: TaskType.OPERATION,
      apiIdentifier: UserSessionService.identifier,
      parameters: UserSessionServiceParams(
        showTimeoutMessage: true,
        type: UserSessionServiceType.end,
      ),
    );
    await taskManager.waitForExecute(newUserSessionTask);
  }
}
