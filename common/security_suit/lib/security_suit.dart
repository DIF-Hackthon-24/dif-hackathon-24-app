import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class SecuritySuit {
  static const _securityChannel = MethodChannel('com.dgda.wadisafar.security_suit/security');
  static const _jailBreakMethod = "isJailBroken";
  static const _debuggerAttached = "isDebuggerAttached";
  static const _appReverseEngineered = "isAppReverseEngineered";

  static Future<bool> isDeviceNotSecure() async {
    try {
      final jailBroken = await FlutterJailbreakDetection.jailbroken;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        
        final developerMode = await FlutterJailbreakDetection.developerMode;
        return jailBroken || developerMode || (!androidInfo.isPhysicalDevice);
      } else {
        return (jailBroken ||
            await _iOSJailBroken() ||
            await _iOSAppReverseEngineered() ||
            await _iOSDebuggerAttached());
      }
    } on PlatformException {
      return true;
    }
  }

  static Future<bool> _iOSDebuggerAttached() async {
    bool? debuggerAttached = await _securityChannel.invokeMethod<bool>(_debuggerAttached);
    return debuggerAttached ?? false;
  }

  static Future<bool> _iOSJailBroken() async {
    bool? jailBreak = await _securityChannel.invokeMethod<bool>(_jailBreakMethod);
    return jailBreak ?? false;
  }

  static Future<bool> _iOSAppReverseEngineered() async {
    bool? jailBreak = await _securityChannel.invokeMethod<bool>(_appReverseEngineered);
    return jailBreak ?? false;
  }
}
