import 'package:core/analytics/i_analytics.dart';

class AnalyticsLogger implements IAnalytics {
  List<IAnalytics> analyticsHandlers;

  AnalyticsLogger(this.analyticsHandlers);

  @override
  void initializeAnalyticsTool({String? projectToken, AnalyticsInitializeStatus? status}) {
    analyticsHandlers.forEach((handler) {
      handler.initializeAnalyticsTool(projectToken: projectToken, status: status);
    });
  }

  @override
  void logEvent(String eventName, [Map<String, dynamic>? properties]) {
    analyticsHandlers.forEach((handler) {
      handler.logEvent(eventName, properties);
    });
  }

  @override
  void logScreen(String screenName) {
    analyticsHandlers.forEach((handler) {
      handler.logScreen(screenName);
    });
  }

  @override
  void logTimedEvent(String eventName, [Map<String, dynamic>? properties]) {
    analyticsHandlers.forEach((handler) {
      handler.logTimedEvent(eventName, properties);
    });
  }

  @override
  void endTimedEvent(String eventName, [Map<String, dynamic>? properties]) {
    analyticsHandlers.forEach((handler) {
      handler.endTimedEvent(eventName, properties);
    });
  }

  @override
  void registerUser(String individualId) {
    analyticsHandlers.forEach((handler) {
      handler.registerUser(individualId);
    });
  }

  @override
  void registerUserProperty(String key, String value) {
    analyticsHandlers.forEach((handler) {
      handler.registerUserProperty(key, value);
    });
  }
}
