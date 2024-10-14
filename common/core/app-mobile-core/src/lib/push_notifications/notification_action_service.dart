import 'dart:async';

import 'package:flutter/services.dart';

class NotificationActionService {
  static const notificationAction =
      MethodChannel('com.dgda.wadisafar.push_notification/notificationaction');
  static const String triggerActionChannelMethod = 'triggerAction';
  static const String getLaunchActionChannelMethod = 'getLaunchAction';
  static const String getShowNotificationChannelMethod = 'getShowNotification';

  final actionTriggeredController = StreamController.broadcast();
  final showNotificationController = StreamController.broadcast();

  NotificationActionService() {
    notificationAction.setMethodCallHandler(handleNotificationActionCall);
  }

  Stream get actionTriggered => actionTriggeredController.stream;

  Stream get showNotification => showNotificationController.stream;

  Future<void> triggerAction({action = String}) async {
    actionTriggeredController.add(action);
  }

  Future<void> showNotificationAction({notificationJson = String}) async {
    showNotificationController.add(notificationJson);
  }

  Future<void> checkLaunchAction() async {
    final action = await notificationAction.invokeMethod(getLaunchActionChannelMethod);
    if (action != null && action.runtimeType == String) {
      await triggerAction(action: action);
    }
  }

  Future<void> handleNotificationActionCall(MethodCall call) async {
    switch (call.method) {
      case triggerActionChannelMethod:
        return triggerAction(action: call.arguments as String);
      case getShowNotificationChannelMethod:
        return showNotificationAction(
          notificationJson: call.arguments as String,
        );
      default:
        throw MissingPluginException();
    }
  }
}
