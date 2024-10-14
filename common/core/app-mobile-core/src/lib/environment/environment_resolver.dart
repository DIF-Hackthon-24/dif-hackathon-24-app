class EnvironmentKeys {
  static const analyticsApiTokenKeyName = 'ANALYTICS_API_TOKEN';
}

enum PSEnvironments {
  dev,
  qa,
  qa2,
  qa3,
  qa4,
  preprod,
  bluepp,
  blueprod,
  /* production,
  mock,*/
}

extension PSEnvExtension on PSEnvironments {
  String get name => toString().split('.').last;
}
