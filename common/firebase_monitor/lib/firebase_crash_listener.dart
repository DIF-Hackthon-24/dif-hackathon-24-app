/* import 'package:core/crash_listener/i_crash_listener.dart';
import 'package:core/logging/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseCrashListener implements ICrashListener {
  @override
  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();

      //Crashlytics is enabled in non-debug builds only...
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    } on Exception catch (exception) {
      PSLogger.logError(exception.toString());
    }
  }

  @override
  void recordCrashes({required bool record}) {
    //Crashlytics is enabled in non-debug builds only...
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(record);
  }

  @override
  void updateUserDetails(String userId) {
    FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  @override
  void updateEnvironemnt(String environment) {
    FirebaseCrashlytics.instance.setCustomKey('ENVIRONMENT', environment);
  }

  @override
  void unhandledExceptions(Object error, StackTrace? trace) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      trace,
      printDetails: kDebugMode,
    );
  }

  @override
  void unhandledErrors(FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
  }
}
 */