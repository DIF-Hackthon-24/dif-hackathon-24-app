import 'package:flutter/material.dart';

class CustomTabsBarWidgetAttribute {
  final CustomTabsBarDataModel dataModel;
  final CustomTabsBarAppearance appearance;
  const CustomTabsBarWidgetAttribute({
    required this.dataModel,
    required this.appearance,
  });
}

class CustomTabsBarDataModel {
  final List<String> tabTitleList;
  final int defaultTabIndex;
  const CustomTabsBarDataModel({
    required this.tabTitleList,
    this.defaultTabIndex = 0,
  });
}

class CustomTabsBarAppearance {
  final Color? textColor;
  final Color? selectedTextColor;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Color? bottomLineColor;
  final double indicatorHeight;
  final double bottomLineHeight;
  final double bottomLineSideMargin;
  final double tabBarHeight;
  final double? fontSize;

  const CustomTabsBarAppearance({
    this.textColor,
    this.selectedTextColor,
    this.backgroundColor,
    this.indicatorColor,
    this.bottomLineColor,
    this.indicatorHeight = 4.0,
    this.bottomLineHeight = 1.0,
    this.bottomLineSideMargin = 16,
    this.fontSize,
    this.tabBarHeight = 55,
  });
}
