class StringConstants {



  StringConstants._();
  static const envDefaultPath = 'assets/environment/.env.default';
  static const envKeyName = 'SECRET_SALT';
  static const appTitle = 'Visitor Pass';
  static const String emptyString = "";

  /// screen names

  /// image paths
  static const String logoPath = "assets/login_logo.png";
  static const String govOfAdhaLogoPath = "assets/gov_of_adha_logo.svg";
  static const String govOfAdhaUAEPassLogoPath = "assets/gov_of_adha_uae_logo.svg";

  /// localisation attribute
  static const String languageFileName = "lang";
  static const String common = "common";
  static const String forceUpgrade = "force_upgrade";
  static const String dictionary = "dictionary";
  static const languageKey = 'languageKey';
  static const uuidKey = 'uuidKey';
  static const arabicKey = "ar";
  static const englishKey = "en";
  static const String androidParamForNotificationHub = "fcm";
  static const String iosParamForNotificationHub = "apns";
  static const mediumArabicFontPath = "assets/fonts/NotoSansArabic-Medium.ttf";
  static const mediumFontPath = "assets/fonts/NotoSans-Medium.ttf";
  static const normalArabicFontPath = "assets/fonts/NotoSansArabic-Regular.ttf";
  static const normalFontPath = "assets/fonts/NotoSans-Regular.ttf";

  static const button = 'Button';

  static const offlineDescriptionEN = 'Slow or no internet connection. Please check your internet settings.';
  static const offlineTitleEN = 'No Internet Connection!';
  static const offlineDescriptionAR = 'اتصال بطيء أو بدون اتصال بالإنترنت. يرجى التحقق من إعدادات الإنترنت الخاصة بك.';
  static const offlineTitleAR = 'لا يوجد اتصال بالإنترنت!';
  static const ANDROID_DOWNLOAD_DIRECTORY = "/storage/emulated/0/Download";

  static const String alphanumericRegex = "[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefca-zA-Z0-9 ]";
  static const String onlyTextWithSpaceRegex = "[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefca-zA-Z ]";
}
