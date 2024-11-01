import 'package:core/push_notifications/device_installation_service.dart';
import 'package:flutter/services.dart';

class NotificationRegistrationService {
  static const notificationRegistration =
      MethodChannel('com.push_notification/notificationregistration');

  static const String refreshRegistrationChannelMethod = 'refreshRegistration';
  static const String installationsEndpoint = 'api/notifications/installations';
  static const String cachedDeviceTokenKey = 'cached_device_token';
  static const String cachedTagsKey = 'cached_tags';

  final deviceInstallationService = DeviceInstallationService();

  Future<void> listenForDeviceToken() async {
    notificationRegistration.setMethodCallHandler(handleNotificationRegistrationCall);
  }

  Future<void> refreshRegistration() async {
   // final currentToken = await deviceInstallationService.getDeviceToken();

  }

  Future<void> handleNotificationRegistrationCall(MethodCall call) async {
    switch (call.method) {
      case refreshRegistrationChannelMethod:
        return refreshRegistration();
      default:
        throw MissingPluginException();
    }
  }
}
