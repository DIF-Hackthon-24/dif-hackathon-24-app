class PushTokenToNotificationHubGraphQLQuery {
  static String getQuery(
      String? deviceToken, String? platform, String? langPreference) {
    return '''
mutation(){
      notification(deviceToken: "$deviceToken", platform: "$platform", langPreference: "$langPreference") {
        message
      }
    }
''';
  }
}
