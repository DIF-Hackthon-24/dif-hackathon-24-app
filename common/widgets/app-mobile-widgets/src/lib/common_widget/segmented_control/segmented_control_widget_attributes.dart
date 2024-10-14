import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';

class PSSegmentedControlAttributes {
  final List<TextUIDataModel> titles;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? activeBgColor;
  final Color? inactiveBgColor;
  final int defaultIndex;
  final double height;
  final double? fixedWidth;
  final double horizontalPadding;
  final double? cornerRadius;
  final ValueChanged<int>? onSelectAction;
  final int? initialIndex;

  /// This is true if the parent widget controls the
  /// currently selected index. This is required to
  /// enable tab page swiping
  bool isControlledByParent;

  PSSegmentedControlAttributes({
    required this.titles,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeBgColor,
    this.inactiveBgColor,
    this.defaultIndex = 0,
    this.height = 48,
    this.fixedWidth,
    this.horizontalPadding = 48,
    this.onSelectAction,
    this.isControlledByParent = false,
    this.cornerRadius = 6.0,
    this.initialIndex,
  });

  PSSegmentedControlAttributes copyWith({
    List<TextUIDataModel>? titles,
    Color? activeTextColor,
    Color? inactiveTextColor,
    Color? activeBgColor,
    Color? inactiveBgColor,
    int? defaultIndex,
    double? height,
    double? fixedWidth,
    double? horizontalPadding,
    double? cornerRadius,
    ValueChanged<int>? onSelectAction,
    int? initialIndex,
  }) =>
      PSSegmentedControlAttributes(
        titles: titles ?? this.titles,
        activeTextColor: activeTextColor ?? this.activeTextColor,
        inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
        activeBgColor: activeBgColor ?? this.activeBgColor,
        inactiveBgColor: inactiveBgColor ?? this.inactiveBgColor,
        defaultIndex: defaultIndex ?? this.defaultIndex,
        height: height ?? this.height,
        fixedWidth: fixedWidth ?? this.fixedWidth,
        horizontalPadding: horizontalPadding ?? this.horizontalPadding,
        cornerRadius: cornerRadius ?? this.cornerRadius,
        onSelectAction: onSelectAction ?? this.onSelectAction,
        initialIndex: initialIndex ?? this.initialIndex,
      );
}
