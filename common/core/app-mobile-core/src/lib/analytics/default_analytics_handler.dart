import 'package:core/analytics/i_analytics.dart';

class DefaultAnalyticsHandler implements IAnalytics {
  @override
  void initializeAnalyticsTool({String? projectToken, AnalyticsInitializeStatus? status}) {
  }

  @override
  void logEvent(String eventName, [Map<String, dynamic>? properties]) {
  }

  @override
  void logScreen(String screenName) {
  }

  @override
  void logTimedEvent(String eventName, [Map<String, dynamic>? properties]) {
  }

  @override
  void endTimedEvent(String eventName, [Map<String, dynamic>? properties]) {
  }

  @override
  void registerUser(String individualId) {
  }

  @override
  void registerUserProperty(String key, String value) {
  }
}
