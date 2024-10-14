import 'package:core/logging/logger.dart';
import 'package:core/notification/notification_constants.dart';
import 'package:core/notification/received_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:task_manager/stream_observer/data_change_observer_resolver.dart';
import 'package:task_manager/task_manager.dart';
import 'package:universal_io/io.dart';


typedef OnSelectNotification = void Function(String? payload);

abstract class INotificationManager {
  Future<void> init(OnSelectNotification onSelectNotification);

  Future<void> showNotification(ReceivedNotification notification);

  Future<void> configureDidReceiveLocalNotificationSubject(
    BuildContext context,
  );
}

class _Constant {
  static const CHANNEL_ID = 'com.dgda.wadisafar';
  static const CHANNEL_NAME = 'ADHA App channel';
}

class NotificationManager implements INotificationManager {
  final TaskManager _taskManager;
  NotificationManager(this._taskManager);
  
  var _onSelectNotification;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  String? selectedNotificationPayload;

  @override
  Future<void> init(OnSelectNotification onSelectNotification) async {
    _onSelectNotification = onSelectNotification;
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_noti');

    final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {
          didReceiveLocalNotificationSubject.add(
            ReceivedNotification(
              id: id,
              title: title,
              body: body,
              payload: payload,
            ),
          );
        },);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
        onSelectNotification(notificationResponse.payload);
        selectedNotificationPayload = notificationResponse.payload;
        selectNotificationSubject.add(notificationResponse.payload);
      },
    );
    _requestPermissions();
  }

  void _requestPermissions() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Future<void> showNotification(ReceivedNotification notification) async {
    //if((notification.data ?? {}).containsKey(NotificationConstants.isSilentKey) && notification.data?[NotificationConstants.isSilentKey] !=null && notification.data?[NotificationConstants.isSilentKey] == 'true'){
    if(notification.data != null){
      await notifierForNotification(
        NotificationConstants.notificationNotifierDataStream(
          notification.data!,
        ),
      );
    }
    if (notification.data?.containsKey(NotificationConstants.isSilentKey) ?? false) {
      dynamic isSilentValue = notification.data![NotificationConstants.isSilentKey];
      bool isSilent = false;
      if(isSilentValue is String){
        isSilent = (isSilentValue.toLowerCase() == 'true');
      } else if(isSilentValue is bool){
        isSilent = isSilentValue;
      }
      if (isSilent) {
        PSLogger.logInfo('Silent Notification Received');
        final notificationType = notification.data?[NotificationConstants.typeKey] ?? '';
        switch(notificationType){
          case NotificationConstants.profileGenerated:
            await updateDashboard(
              NotificationConstants.profileGeneratedUpdateStreamKey,
            );
            break;
          case NotificationConstants.applicationSubmitted:
          case NotificationConstants.applicationINVSNT:
          case NotificationConstants.applicationINV_SENT:
          case NotificationConstants.parked:
          case NotificationConstants.rejected_application:
          case NotificationConstants.cancel_application:
            PSLogger.logInfo('Silent push received to refresh active applications.');
            await updateDashboard(NotificationConstants.refreshActiveApplicationsStreamKey);
            break;
        }
      }else{
        await _showNonSilentNotification(notification);
      }
    }else{
      await _showNonSilentNotification(notification);
    }
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

  Future<void> notifierForNotification(Map<String, dynamic> data) async {
    await _taskManager.waitForExecute(Task(
      parameters: DataChangeObserverTaskParams(
        type: DataNotifierTaskType.SET,
        setKeys: data,
      ),
      taskType: TaskType.DATA_NOTIFIER,
    ));
  }

  @override
  Future<void> configureDidReceiveLocalNotificationSubject(
      BuildContext context,) async {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                _onSelectNotification(receivedNotification.payload);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    });
  }

  Future<void> _showNonSilentNotification(ReceivedNotification notification) async{
      String longdata = notification.body.toString();
    var bigTextStyleInformation =  BigTextStyleInformation(longdata);
     AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      _Constant.CHANNEL_ID,
      _Constant.CHANNEL_NAME,
      importance: Importance.max,
      color: const Color(0xFFC7BDBA),
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails();

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
  
    if(Platform.isAndroid){
      await _flutterLocalNotificationsPlugin.show(
       notification.id,
       notification.title,
       notification.body,
       platformChannelSpecifics,
       payload: notification.payload,
     );
    }
  }
}

