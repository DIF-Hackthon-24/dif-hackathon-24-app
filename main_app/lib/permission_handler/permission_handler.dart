import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{
  Future<bool> getStorgagePermission() async {
    if (Platform.isAndroid) {
      bool storage = true;
      bool photos = true;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        await Permission.photos.request();
        photos = await Permission.photos.isGranted;
      } else {
        await Permission.storage.request();
        storage = await Permission.storage.status.isGranted;
      }
      if (storage && photos) {
        return true;
      } else {
        return false;
      }
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isDenied) {
        return false;
      }
      return true;
    }
  }

  Future<void> getNotificationPermission() async {
    //Exclusive to Android 13 and above
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        await Permission.notification.request();
      }
    }
  }
}