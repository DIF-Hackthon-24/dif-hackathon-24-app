import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class SearchBarAttributes {
  final SearchBarDataModel dataModel;
  final SearchBarAppearance appearance;

  const SearchBarAttributes({
    this.dataModel = const SearchBarDataModel(),
    this.appearance = const SearchBarAppearance(),
  });

  SearchBarAttributes copyWith({
    required final SearchBarDataModel dataModel,
    required final SearchBarAppearance appearance,
  }) =>
      SearchBarAttributes(
        dataModel: dataModel,
        appearance: appearance,
      );
}

class SearchBarDataModel {
  final String hint;
  final PSTextStyleVariant? variant;

  const SearchBarDataModel({
    this.hint = ' ',
    this.variant,
  });
}

class SearchBarAppearance {
  final String suffixIcon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconWidth;
  final double height;
  final double contentPadding;
  final double iconPadding;
  final double cornerRadius;

  const SearchBarAppearance({
    this.suffixIcon = '',
    this.backgroundColor,
    this.iconColor,
    this.height = 56,
    this.contentPadding = 16,
    this.iconPadding = 16,
    this.cornerRadius = 4,
    this.iconWidth,
  });
}
