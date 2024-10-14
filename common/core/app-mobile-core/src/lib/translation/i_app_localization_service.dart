abstract class IAppLocalizationService {
  /// Gets the value of the localized key.
  /// The localization strings support `sprintf` format modifiers
  /// See [Flutter sprintf](https://pub.dev/packages/sprintf)
  String getValue(String key, {List<dynamic> args = const []});

  Map<String,dynamic>? getMap(String key);
}
