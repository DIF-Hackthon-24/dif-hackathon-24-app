part of 'app_font_style.dart';

class _Constants {
  static const wadiSafarMedium = 'WadiSafar-Medium';
  static const wadiSafarLight = 'WadiSafar-Light';
  static const wadiSafarArabicMedium = 'WadiSafarArabic-Medium';
  static const wadiSafarArabicLight = 'WadiSafarArabic-Light';

  static const ibmPlexSansBold = 'IBMPlexSans-Bold';
  static const ibmPlexSansMedium = 'IBMPlexSans-Medium';
  static const ibmPlexSansRegular = 'IBMPlexSans-Regular';

  static const ibmPlexSansArabicBold = 'IBMPlexSansArabic-Bold';
  static const ibmPlexSansArabicMedium = 'IBMPlexSansArabic-Medium';
  static const ibmPlexSansArabicRegular = 'IBMPlexSansArabic-Regular';
}

enum AppFontFamilyTypes {
  wadiSafarMedium,
  wadiSafarLight,

  ibmPlexSansBold,
  ibmPlexSansMedium,
  ibmPlexSansRegular,
}

extension AppFontFamilyTypesExt on AppFontFamilyTypes {
  String get toName {
    switch (this) {
      case AppFontFamilyTypes.wadiSafarMedium:
        if (AppThemeConfig.instance.selectedLanguage ==
            AppLocalizeLanguage.en) {
          return _Constants.wadiSafarMedium;
        }
        return _Constants.wadiSafarArabicMedium;

      case AppFontFamilyTypes.wadiSafarLight:
        if (AppThemeConfig.instance.selectedLanguage ==
            AppLocalizeLanguage.en) {
          return _Constants.wadiSafarLight;
        }
        return _Constants.wadiSafarArabicLight;

      case AppFontFamilyTypes.ibmPlexSansBold:
        if (AppThemeConfig.instance.selectedLanguage ==
            AppLocalizeLanguage.en) {
          return _Constants.ibmPlexSansBold;
        }
        return _Constants.ibmPlexSansArabicBold;  

      case AppFontFamilyTypes.ibmPlexSansMedium:
        if (AppThemeConfig.instance.selectedLanguage ==
            AppLocalizeLanguage.en) {
          return _Constants.ibmPlexSansMedium;
        }
        return _Constants.ibmPlexSansArabicMedium;    
      
      case AppFontFamilyTypes.ibmPlexSansRegular:
        if (AppThemeConfig.instance.selectedLanguage ==
            AppLocalizeLanguage.en) {
          return _Constants.ibmPlexSansRegular;
        }
        return _Constants.ibmPlexSansArabicRegular;    
    }
  }
}
