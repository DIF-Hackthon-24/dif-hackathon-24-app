/* import 'package:core/analytics/i_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseAnalyticsLogger implements IAnalytics {
  @override
  void initializeAnalyticsTool({String? projectToken, AnalyticsInitializeStatus? status}) async {
    await Firebase.initializeApp();
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!kDebugMode);
  }

  @override
  void registerUser(String userId) {
    FirebaseAnalytics.instance.setUserId(id: userId);
  }

  @override
  void registerUserProperty(String key, String value) async {
    await FirebaseAnalytics.instance.setUserProperty(name: key, value: value);
  }

  @override
  void logScreen(String screenName) async {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
  }

  @override
  Future<void> logEvent(String eventName, [Map<String, dynamic>? properties]) async {
    await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: properties);
  }

  @override
  void logTimedEvent(String eventName, [Map<String, dynamic>? properties]) async {
    await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: properties);
  }

  @override
  void endTimedEvent(String eventName, [Map<String, dynamic>? properties]) async {
    await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: properties);
  }
}
 */