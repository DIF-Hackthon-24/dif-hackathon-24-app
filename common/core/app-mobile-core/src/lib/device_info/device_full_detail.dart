import 'package:device_info/device_info.dart';
import 'package:universal_io/io.dart';
import 'dart:io' show Platform;

class DeviceInfo {
  static final _deviceInfo = DeviceInfoPlugin();
  static Future<String> getDeviceId() async {
    if (Platform.isIOS) {
      var iosDeviceInfo = await _deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await _deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  static Future<String> getDeviceName() async {
    if (Platform.isIOS) {
      var iosDeviceInfo = await _deviceInfo.iosInfo;
      return iosDeviceInfo.name;
    } else {
      var androidDeviceInfo = await _deviceInfo.androidInfo;
      return androidDeviceInfo.manufacturer + ' ' + androidDeviceInfo.model;
    }
  }

  static Future<Map<String,dynamic>?> getAllDeviceIfno() async {
    
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return <String,dynamic>{
        'version' : androidInfo.version.baseOS ?? '',
        'device' : androidInfo.device,
        'display': androidInfo.display,
        'manufacturer': androidInfo.manufacturer,
        'model': androidInfo.model,
        'isPhysicalDevice': androidInfo.isPhysicalDevice,
        'androidId': androidInfo.androidId,
        'tags': androidInfo.tags,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return <String,dynamic>{
        'isPhysicalDevice': iosInfo.isPhysicalDevice,
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
        'model': iosInfo.model,
        'localizedModel': iosInfo.localizedModel,
        'identifierForVendor': iosInfo.identifierForVendor,
      };
    }
    return null;
  }

  static Future<String> getDeviceOsVersion() async {

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.release;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo ;
      return iosInfo.systemVersion;
    }
    return '';
  }
}
