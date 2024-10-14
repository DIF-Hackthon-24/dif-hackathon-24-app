import 'package:flutter/services.dart';

class DeviceInstallationService {
  static const methodChannel = MethodChannel(
      'com.dgda.wadisafar.push_notification/deviceinstallation');
  static const String getDeviceIdChannelMethod = 'getDeviceId';
  static const String getDeviceTokenChannelMethod = 'getDeviceToken';
  static const String getDevicePlatformChannelMethod = 'getDevicePlatform';

  /*
  Future<String?> getDeviceId() {
    return methodChannel.invokeMethod<String>(getDeviceIdChannelMethod);
  }
      */

  Future<String?> getDeviceToken() {
    return methodChannel.invokeMethod<String>(getDeviceTokenChannelMethod);
  }

  /*
  Future<String?> getDevicePlatform() {
    return methodChannel.invokeMethod<String>(getDevicePlatformChannelMethod);
  }
   */
}
