import 'package:theme_font/color/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_font/config/theme_config.dart';

part '_font_style.dart';
part '_font_family.dart';

/// https://www.figma.com/design/fZabMBSR1aCAdte31bv7xU/Wadi-Safar-Sales-Tablet-App?node-id=440-2175&t=e5CxeMr6fIrF03wv-0

class AppFontStyle {
  static TextStyle style({
    required FontTypography typography,
    required AppThemeColors color,
  }) {
    switch (typography) {
      case FontTypography.heading1Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarMedium.toName,
          fontSize: 90,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.heading1Light:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarLight.toName,
          fontSize: 80,
          fontWeight: FontWeight.w300,
          color: color.toColor,
        );

      case FontTypography.heading2Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarMedium.toName,
          fontSize: 60,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.heading2Light:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarLight.toName,
          fontSize: 60,
          fontWeight: FontWeight.w300,
          color: color.toColor,
        );

      case FontTypography.heading3Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarMedium.toName,
          fontSize: 48,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.heading3Light:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarLight.toName,
          fontSize: 48,
          fontWeight: FontWeight.w300,
          color: color.toColor,
        );

      case FontTypography.heading4Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarMedium.toName,
          fontSize: 34,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.heading4Light:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarLight.toName,
          fontSize: 34,
          fontWeight: FontWeight.w300,
          color: color.toColor,
        );

      case FontTypography.heading5Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarMedium.toName,
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.heading5Light:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarLight.toName,
          fontSize: 26,
          fontWeight: FontWeight.w300,
          color: color.toColor,
        );

      case FontTypography.heading6Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarMedium.toName,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.heading6Light:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.wadiSafarLight.toName,
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: color.toColor,
        );

      case FontTypography.body01Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansMedium.toName,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.body01Regular:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansRegular.toName,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: color.toColor,
        );

      case FontTypography.body02Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansMedium.toName,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color.toColor,
        );

      case FontTypography.body02Regular:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansRegular.toName,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: color.toColor,
          letterSpacing: 0.2,
        );

       case FontTypography.body03Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansMedium.toName,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color.toColor,
          letterSpacing: 0.3,
        );

      case FontTypography.body03Regular:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansRegular.toName,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: color.toColor,
          letterSpacing: 0.2,
        );

      case FontTypography.body04Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansMedium.toName,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color.toColor,
          letterSpacing: 0.9,
        );

      case FontTypography.body04Regular:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansRegular.toName,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color.toColor,
          letterSpacing: 1.0,
        );

      case FontTypography.button1Bold:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansBold.toName,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color.toColor,
          letterSpacing: 0.0,
        );

      case FontTypography.button1Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansMedium.toName,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color.toColor,
          letterSpacing: 0.0,
        );

      case FontTypography.button1Regular:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansRegular.toName,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: color.toColor,
          letterSpacing: 0.0,
        );

      case FontTypography.button2Bold:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansBold.toName,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color.toColor,
          letterSpacing: 0.0,
        );

      case FontTypography.button2Medium:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansMedium.toName,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color.toColor,
          letterSpacing: 0.0,
        );

      case FontTypography.button2Regular:
        return TextStyle(
          fontFamily: AppFontFamilyTypes.ibmPlexSansRegular.toName,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: color.toColor,
          letterSpacing: 0.0,
        );
    }
  }

  static TextStyle custom({
    required double fontSize,
    required FontWeight fontWeight,
    required AppThemeColors color,
    required AppFontFamilyTypes fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily.toName,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color.toColor,
    );
  }
}
