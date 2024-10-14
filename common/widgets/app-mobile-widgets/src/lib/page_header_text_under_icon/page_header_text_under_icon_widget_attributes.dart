import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/padding.dart';

enum PSPageHeaderTextUnderIconWidgetTextElementType {
  header,
  subHeader,
  date,
}

enum PSPageHeaderTextUnderIconPosition {
  top,
  left,
  right,
}

enum PSPageHeaderTextUnderIconWidgetElementFormat {
  vertical,
  horizontal,
}

class PSPageHeaderTextUnderIconWidgetElementAttributes {
  final String? icon;
  final Color? iconColor;
  final double? cornerRadius;
  final double? iconBottomMargins;
  final double? iconHeight;
  TextUIDataModel? title;
  final List<String>? highlightedTexts;
  final FontWeight? fontWeight;
  final Color? highlighterTextColor;
  final Function()? onPressed;
  final PSPadding? padding;
  final PSPageHeaderTextUnderIconWidgetTextElementType type;
  final PSPageHeaderTextUnderIconWidgetElementFormat format;
  final PSPageHeaderTextUnderIconPosition position;

  PSPageHeaderTextUnderIconWidgetElementAttributes({
    this.icon,
    this.iconHeight,
    this.iconBottomMargins,
    this.iconColor,
    this.cornerRadius,
    this.title,
    this.highlightedTexts,
    this.highlighterTextColor,
    this.padding,
    this.onPressed,
    this.fontWeight,
    this.position = PSPageHeaderTextUnderIconPosition.top,
    this.type = PSPageHeaderTextUnderIconWidgetTextElementType.header,
    this.format = PSPageHeaderTextUnderIconWidgetElementFormat.vertical,
  });

  PSPageHeaderTextUnderIconWidgetElementAttributes copyWith({
    final String? icon,
    final Color? iconColor,
    final double? cornerRadius,
    final TextUIDataModel? title,
    final List<String>? highlightedTexts,
    final Color? highlighterTextColor,
    final Function()? onPressed,
    final PSPadding? padding,
    final PSPageHeaderTextUnderIconWidgetTextElementType? type,
    final PSPageHeaderTextUnderIconWidgetElementFormat? format,
    final FontWeight? fontWeight,
  }) =>
      PSPageHeaderTextUnderIconWidgetElementAttributes(
        icon: icon ?? this.icon,
        iconColor: iconColor ?? this.iconColor,
        cornerRadius: cornerRadius ?? this.cornerRadius,
        title: title ?? this.title,
        highlightedTexts: highlightedTexts ?? this.highlightedTexts,
        highlighterTextColor: highlighterTextColor ?? this.highlighterTextColor,
        onPressed: onPressed ?? this.onPressed,
        padding: padding ?? this.padding,
        type: type ?? this.type,
        format: format ?? this.format,
        fontWeight: fontWeight ?? this.fontWeight,
      );
}

class PSPageHeaderTextUnderIconWidgetAttributes {
  final List<PSPageHeaderTextUnderIconWidgetElementAttributes> attributesList;
  final double headerTopPadding;
  final double leftMargin;
  final double rightMargin;
  final double headerBottomPadding;
  final CrossAxisAlignment crossAxisAlignment;

  PSPageHeaderTextUnderIconWidgetAttributes({
    required this.attributesList,
    this.headerTopPadding = 67,
    this.headerBottomPadding = 13,
    this.leftMargin = 32,
    this.rightMargin = 0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  PSPageHeaderTextUnderIconWidgetAttributes copyWith({
    final List<PSPageHeaderTextUnderIconWidgetElementAttributes>? attributesList,
    final double? headerTopPadding,
    final double? leftMargin,
    final double? rightMargin,
    final double? headerBottomPadding,
    final CrossAxisAlignment? crossAxisAlignment,
  }) =>
      PSPageHeaderTextUnderIconWidgetAttributes(
        attributesList: attributesList ?? this.attributesList,
        headerBottomPadding: headerBottomPadding ?? this.headerBottomPadding,
        headerTopPadding: headerTopPadding ?? this.headerTopPadding,
        leftMargin: leftMargin ?? this.leftMargin,
        rightMargin: rightMargin ?? this.rightMargin,
        crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      );
}
