
import 'package:flutter/material.dart';

enum NotificationIcon {
  warning, checkMark
}
extension NotificationIconExtension on NotificationIcon {
  String get getIcon {
    switch (this) {
      case NotificationIcon.warning:
        return _Constants.warningSymbol;
      default:
        return _Constants.tickGreenSymbol;
    }
  }
}
class _Constants {
  static const warningSymbol = 'assets/images/warning_symbol.svg';
  static const tickGreenSymbol = 'assets/images/checkmark_icon.svg';
}

class SendReportOverlayNotificationAttributes {
  final String title;
  final List<TextSpanAttributes> description;
  final NotificationIcon iconType;
  final bool isArabic;

  SendReportOverlayNotificationAttributes({
    required this.title,
    required this.description,
    required this.iconType,
    required this.isArabic,
  });
}

class TextSpanAttributes {
  final String text;
  final TextStyle style;

  TextSpanAttributes({
    required this.text,
    required this.style,
  });
}