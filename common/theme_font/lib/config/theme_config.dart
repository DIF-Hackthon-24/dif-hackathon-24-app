
enum AppTheme {
  light,
  dark,
}
enum AppLocalizeLanguage {
  en,
  ar,
}

class AppThemeConfig {
  static final AppThemeConfig _instance = AppThemeConfig._();

  AppThemeConfig._();

  static AppThemeConfig get instance => _instance;

  var selectedAppTheme = AppTheme.light;
  var selectedLanguage = AppLocalizeLanguage.en;

  bool get isEnglish {
    return selectedLanguage == AppLocalizeLanguage.en;
  }

  bool get isLightTheme {
    return selectedAppTheme == AppTheme.light;
  }

  void setAppTheme(AppTheme theme){
    selectedAppTheme = theme;
  }

  void setAppLocalizeLanguage(AppLocalizeLanguage language) {
    selectedLanguage = language;
  }

  AppLocalizeLanguage getAppLocalizeLanguage() {
    return selectedLanguage;
  }
}
