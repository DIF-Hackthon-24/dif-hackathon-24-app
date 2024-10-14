import 'package:flutter/material.dart';
class _Constants{
  static const fontFamily = 'NotoSans-medium';
  static const arabicSuffix = 'Arabic';
}

class CustomFontFamily{
  
  String getFontFamily(BuildContext context) {
  final language = Localizations.localeOf(context).languageCode;
  return language == 'ar' ? '${_Constants.fontFamily}${_Constants.arabicSuffix}' : _Constants.fontFamily;
  }
}