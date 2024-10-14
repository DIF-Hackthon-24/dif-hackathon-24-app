import 'dart:async';

import 'package:core/ioc/di_container.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/session_management/inactivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:task_manager/session_management/token_refresh_service/domain/token_refresh_use_case.dart';
import 'package:task_manager/session_management/user_session/user_session_service.dart';
import 'package:task_manager/session_management/user_session/user_session_service_params.dart';
import 'package:task_manager/task_manager.dart';
import 'package:widget_library/change_application_popup.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class _Constants {
  static const inactivityTimeout = 30 * 60 * 1000; // 30 minutes in milliseconds
  static const storageKey = 'app-inactive-since';
  static const userInteractionTime = 1 * 60 * 1000; // 1 minute in milliseconds
  static const logoutIcon = 'widget_library:assets/images/bottomsheet_logout.svg';
  static const throttleTime = Duration(milliseconds: 1000);
  // static const double bottomSheetRadius = 20;
  static const commonKey = 'common';
  static const langKey = 'lang';
  static const headerTitleKey = 'adhaTimeoutPopupHeader';
  static const btnLabelKey = 'adhaTimeoutPopupBtnLabel';
  static const descriptionkey = 'adhaTimeoutPopupDescription';
}

/// Service to manage an inactivity timer that will logout the user when triggered.
class InactivityService extends IInactivityService {
  final int inactivityTimeout;
  final TaskManager taskManager;
  final bool isTouchInteractionTimerEnabled;

  InactivityService({
    required this.taskManager,
    this.inactivityTimeout = _Constants.inactivityTimeout,
    this.isTouchInteractionTimerEnabled = true,
  });

  Timer? _inactivityTimer;
  DateTime _inactiveStart = DateTime.now();
  Timer? _userInteractionTimer;
  bool _isDialogShown = false;

  // Internal flag to determine if the timer is considered active
  bool _timerIsActive = false;

  Duration? _inactivityDuration;
  StreamController<dynamic>? _controller;
  Duration? _userInteractivityTimerDuration;

  // Combines events from a stream and only emits one event during the Duration
  final throttle = StreamTransformer.fromBind((Stream<dynamic> s) => s.throttle(_Constants.throttleTime));

  @override
  void start() {
    _inactivityDuration = Duration(milliseconds: inactivityTimeout);
    _resetTimer(DateTime.now());

    _controller = StreamController();

    _controller?.stream.transform<dynamic>(throttle).listen((event) async {
      if (_timerIsActive && isTouchInteractionTimerEnabled) {
        _resetTimer(DateTime.now());
      }
    });
  }

  void dispose() {
    _timerIsActive = false;
    _inactivityTimer?.cancel();
    _userInteractionTimer?.cancel();
    _controller?.close();
  }

  @override
  Future<bool> movedToBackground() async {
    await taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.SET,
          writeValues: {
            _Constants.storageKey: _inactiveStart.microsecondsSinceEpoch.toString(),
          },
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );

    return Future.value(true);
  }

  @override
  Future<bool> movedToForeground() async {
    final result = await taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.GET,
          readValues: [_Constants.storageKey],
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );

    final time = result?[_Constants.storageKey];

    DateTime? dt;
    if (time != null) {
      dt = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(time) ?? 0);
    }

    _resetTimer(dt ?? DateTime.now());

    return Future.value(true);
  }

  void _resetTimer(DateTime startTime) async {
    _inactivityTimer?.cancel();
    _userInteractionTimer?.cancel();
    if (_inactivityDuration == null) {
      return;
    }
    if (!_timerIsActive) {
      return;
    }
    if (startTime.add(_inactivityDuration!).isBefore(DateTime.now())) {
      // We've already timed out, perhaps as a result of being resumed.
      var timeSinceExpired = DateTime.now().difference(startTime.add(_inactivityDuration!));
      if (timeSinceExpired.inMilliseconds < _Constants.userInteractionTime) {
        _userInteractivityTimerDuration = Duration(milliseconds: _Constants.userInteractionTime) - timeSinceExpired;
      } else {
        _userInteractivityTimerDuration = Duration(microseconds: 0);
      }
      await _timedOut();
    } else {
      _inactiveStart = startTime;
      _inactivityTimer = Timer(_inactivityDuration!, () async => await _timedOut());
    }
  }

  // ignore: long-method
  Future _timedOut() async {
    final _authManager = DIContainer.container.resolve<IAuthManager>();
    final isUserAuthenticated = await _authManager.isUserAuthenticated();
    if (!isUserAuthenticated) {
      stopTimer();
      return;
    }

    if (_isDialogShown) {
      NavigationManager.goBack();
      _isDialogShown = false;
    }
    _isDialogShown = true;

    Get.bottomSheet(
      await _getBottomSheet(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
    );

    _userInteractionTimer = Timer(_userInteractivityTimerDuration!, () async {
      if (_isDialogShown) {
        _isDialogShown = false;

        //Perform a logout
        var newUserSessionTask = Task(
          taskType: TaskType.OPERATION,
          apiIdentifier: UserSessionService.identifier,
          parameters: UserSessionServiceParams(
            showTimeoutMessage: true,
            type: UserSessionServiceType.end,
          ),
        );

        _timerIsActive = false;
        NavigationManager.goBack();

        await taskManager.waitForExecute(newUserSessionTask);
      }
    });
  }

  @override
  void stopTimer() {
    _inactivityTimer?.cancel();
    _userInteractionTimer?.cancel();
    _timerIsActive = false;
  }

  @override
  void startTimer({DateTime? expiryTime}) {
    _timerIsActive = true;
    _userInteractivityTimerDuration = Duration(milliseconds: _Constants.userInteractionTime);
    if (expiryTime != null) {
      _inactivityDuration = expiryTime.difference(DateTime.now()) -
          Duration(
            milliseconds: _Constants.userInteractionTime,
          );
    }
    _resetTimer(DateTime.now());
  }

  @override
  void registerInteraction(dynamic event) => _controller?.sink.add(event);

  Future<Widget> _getBottomSheet() async {
    var localizationData = await taskManager.waitForExecute(
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_GET,
          readValues: [_Constants.langKey],
        ),
      ),
    );
    var languageContent = {};
    if (localizationData != null) {
      languageContent = await localizationData[_Constants.langKey] ?? {};
    }

    var commonContent = languageContent[_Constants.commonKey] as Map<String, dynamic>? ?? {};

    return Theme(
      data: PSTheme().themeFor('change_application'),
      child: ChangeApplicationBottomSheet(
        attributes: ShowModalBottomSheetInfoAttributes(
          iconAttributes: IconAttributes(
            iconPath: _Constants.logoutIcon,
          ),
          title: commonContent[_Constants.headerTitleKey] as String? ?? '',
          secondaryCTAText: commonContent[_Constants.btnLabelKey] as String? ?? '',
          primaryCtaEnabled: false,
          description: commonContent[_Constants.descriptionkey] as String? ?? '',
          showDescription: true,
          showSubDescription: false,
          timerDurationInSeconds: _userInteractivityTimerDuration?.inSeconds,
          confirmButtonOnTap: () async {
            _isDialogShown = false;
            NavigationManager.goBack();
            await TokenRefreshUseCase(this.taskManager).refreshToken();
          },
          showProgressEnabled:true,
          inactiveHeader: true,
        ),
      ),
    );
  }
}
