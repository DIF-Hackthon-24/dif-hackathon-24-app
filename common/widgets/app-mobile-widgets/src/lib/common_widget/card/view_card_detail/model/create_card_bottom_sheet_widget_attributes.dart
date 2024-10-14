import 'package:flutter/material.dart';
import 'package:widget_library/padding.dart';

import 'card_detail_bottom_sheet_model.dart';

class CreateCardBottomSheetWidgetAttributes {
  final CardRowHeaderModel? createCardHeaderText;
  final List<CreateCardRowModel>? createCardData;
  final Color? shadowColor;
  final PSPadding borderPadding;

  CreateCardBottomSheetWidgetAttributes({
    this.createCardHeaderText,
    this.createCardData,
    this.shadowColor,
    this.borderPadding = const PSPadding(left: 0, right: 0, top: 32, bottom: 32, width: 0, height: 320),
  });
}

class CreateCardRowModel {
  final String? labelTitle;
  final String? labelDescription;
  final String? labelAction;
  final String? iconPath;
  final String? secondIconPath;
  final Color background;
  final Color? foreground;
  final Function()? action;
  final PSPadding? padding;
  final bool cardComingSoon;
  final Color? comingSoonBackground;
  final String? comingSoonTitle;
  CreateCardRowModel({
    this.labelTitle,
    this.labelDescription,
    this.labelAction,
    this.iconPath,
    this.secondIconPath,
    required this.background,
    this.foreground,
    this.padding,
    this.action,
    this.cardComingSoon = false,
    this.comingSoonBackground,
    this.comingSoonTitle,
  });
}
