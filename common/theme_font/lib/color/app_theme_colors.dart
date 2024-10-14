import 'package:flutter/material.dart';
import 'package:theme_font/config/theme_config.dart';

/// https://www.figma.com/design/fZabMBSR1aCAdte31bv7xU/Wadi-Safar-Sales-Tablet-App?node-id=440-3669&t=VwGfLzgUvTEOCTbw-0

part '_app_colors.dart';

enum AppThemeColors {
  charcoal,
  white,
  sandstone100,
  sandstone40,
  sandstone25,
  brownChert,
  paleBrownAnhydrite100,
  paleBrownAnhydrite30,
  redDolomite,
  royalRed,
  brownChert40
}

extension AppThemeColorsExt on AppThemeColors {
  Color get toColor {
    switch (this) {
      case AppThemeColors.charcoal:
        return _AppColors.charcoal;

      case AppThemeColors.white:
        return _AppColors.white;

      case AppThemeColors.sandstone100:
        return _AppColors.sandstone100;

      case AppThemeColors.sandstone40:
        return _AppColors.sandstone40;

      case AppThemeColors.sandstone25:
        return _AppColors.sandstone25;

      case AppThemeColors.brownChert:
        return _AppColors.brownChert;

      case AppThemeColors.brownChert40:
        return _AppColors.brownChert40;
      case AppThemeColors.paleBrownAnhydrite100:
        return _AppColors.paleBrownAnhydrite100;

      case AppThemeColors.paleBrownAnhydrite30:
        return _AppColors.paleBrownAnhydrite30;

      case AppThemeColors.redDolomite:
        return _AppColors.redDolomite;

      case AppThemeColors.royalRed:
        return _AppColors.royalRed;

      default:
        return _AppColors.charcoal;
    }
  }
}
