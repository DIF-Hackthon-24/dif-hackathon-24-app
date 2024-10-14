part of 'app_theme_colors.dart';

/// https://www.figma.com/design/fZabMBSR1aCAdte31bv7xU/Wadi-Safar-Sales-Tablet-App?node-id=440-3669&t=VwGfLzgUvTEOCTbw-0

class _AppColors {
  static bool get _isLightTheme {
    return AppThemeConfig.instance.isLightTheme;
  }

  /// Primary ///
  static Color get charcoal {
    if (_isLightTheme) {
      return const Color(0xFF000000);
    }
    return const Color(0xFF000000);
  }

  static Color get white {
    if (_isLightTheme) {
      return const Color(0xFFFFFFFF);
    }
    return const Color(0xFFFFFFFF);
  }

  static Color get sandstone100 {
    if (_isLightTheme) {
      return const Color(0xFFF4E5D2);
    }
    return const Color(0xFFF4E5D2);
  }

  static Color get sandstone40 {
    if (_isLightTheme) {
      return const Color(0xFFFBF5ED);
    }
    return const Color(0xFFFBF5ED);
  }

  static Color get sandstone25 {
    if (_isLightTheme) {
      return const Color(0xFFFCF9F4);
    }
    return const Color(0xFFFCF9F4);
  }

  /// Secondary ///

  static Color get brownChert40 {
    if (_isLightTheme) {
      return const Color(0xFF5D4632).withOpacity(.40);
    }
    return const Color(0xFF5D4632).withOpacity(.40);
  }
  static Color get brownChert {
    if (_isLightTheme) {
      return const Color(0xFF5D4632);
    }
    return const Color(0xFF5D4632);
  }

  static Color get paleBrownAnhydrite100 {
    if (_isLightTheme) {
      return const Color(0xFF9F8576);
    }
    return const Color(0xFF9F8576);
  }

  static Color get paleBrownAnhydrite30 {
    if (_isLightTheme) {
      return const Color(0xFFE2DAD6);
    }
    return const Color(0xFFE2DAD6);
  }

  /// Highlight ///

  static Color get redDolomite {
    if (_isLightTheme) {
      return const Color(0xFFB47046);
    }
    return const Color(0xFFB47046);
  }

  static Color get royalRed {
    if (_isLightTheme) {
      return const Color(0xFFC02916);
    }
    return const Color(0xFFC02916);
  }
}
