import 'dart:convert';

import 'package:core/logging/logger.dart';
import 'package:core/notification/notification_constants.dart';
import 'package:core/notification/notification_manager.dart';
import 'package:core/notification/received_notification.dart';
import 'package:core/push_notifications/notification.dart';
import 'package:task_manager/stream_observer/data_change_observer_resolver.dart';
import 'package:task_manager/task_manager.dart';

import 'notification_action_service.dart';
import 'notification_registration_service.dart';

class PushNotificationManager {
  final INotificationManager _notificationManager;
  final NotificationRegistrationService _notificationRegistrationService;
  final NotificationActionService _notificationActionService;
  final TaskManager _taskManager;

  PushNotificationManager(
    this._notificationManager,
    this._notificationRegistrationService,
    this._notificationActionService,
    this._taskManager,
  );

  void init() async {
    await _notificationRegistrationService.listenForDeviceToken();
    await _notificationManager.init(onSelectNotification);

    _notificationActionService.actionTriggered.listen((data) {
        final deeplink = data as String;
        onSelectNotification(deeplink);
        processBundle(deeplink);
    });

    _notificationActionService.showNotification.listen((data) {
      final notificationJson = data as String;
      Map<String, dynamic> notificationMap =
          jsonDecode(notificationJson) as Map<String, dynamic>;
      final notification = Notification.fromJson(notificationMap);
      showNotification(notification);
    });
    await _notificationActionService.checkLaunchAction();
  }

  void processBundle(String value) async {
    try{
    var valueMap = json.decode(value) as Map<String, dynamic>;
      var silentNotification = SilentNotification.fromMap(valueMap);
      dynamic isSilentValue = silentNotification.isSilent;
      bool isSilent = false;
      if (isSilentValue is String) {
        isSilent = (isSilentValue.toLowerCase() == 'true');
      } else if (isSilentValue is bool) {
        isSilent = isSilentValue;
      }
      if (isSilent) {
        await performOperations(silentNotification.type ?? '');
      }
    }catch(e){
      PSLogger.logError(e.toString());
    }
  }

  Future<void> performOperations(String type) async {
    switch(type){
      case NotificationConstants.profileGenerated:
        await updateDashboard(NotificationConstants.profileGeneratedUpdateStreamKey);
        break;
      case NotificationConstants.applicationSubmitted:
      case NotificationConstants.applicationINVSNT:
      case NotificationConstants.applicationINV_SENT:
        PSLogger.logInfo('Silent push received to refresh active applications.');
        await updateDashboard(NotificationConstants.refreshActiveApplicationsStreamKey);
        break;
      default:
        break;
    }
  }

  void showNotification(Notification notification) async {
    await _notificationManager.showNotification(
      ReceivedNotification(
        id: notification.id ?? DateTime.now().millisecond,
        title: notification.title,
        body: notification.body,
        payload: notification.data?['deeplink'] as String?,
        data: notification.data ?? {},
      ),
    );
  }

  void onSelectNotification(String? deeplink) {
    if (deeplink != null);
  }

  Future<void> updateDashboard(Map<String, dynamic>? key)async{
    await _taskManager.waitForExecute(Task(
      parameters: DataChangeObserverTaskParams(
        type: DataNotifierTaskType.SET,
        setKeys: key,
      ),
      taskType: TaskType.DATA_NOTIFIER,
    ));
  }
}
