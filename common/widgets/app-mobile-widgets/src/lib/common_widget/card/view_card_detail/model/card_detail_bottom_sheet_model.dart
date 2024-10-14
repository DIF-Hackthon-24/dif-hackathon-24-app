import 'package:flutter/material.dart';
import 'package:widget_library/padding.dart';
import 'package:widget_library/page_header_text_under_icon/page_header_text_under_icon_widget_attributes.dart';

class ViewPinAttribute {
  final CardRowHeaderModel? viewPinHeaderText;
  final String? viewPinText;

  ViewPinAttribute(this.viewPinHeaderText, this.viewPinText);
}

class CardDetailsAttribute {
  final CardRowHeaderModel? cardHeaderText;
  final List<CardDetailTitleAndSubTitleModel>? cardMapData;

  CardDetailsAttribute({
    this.cardHeaderText,
    this.cardMapData,
  });
}

class CardDetailTitleAndSubTitleModel {
  final String? labelText;
  final String? titleText;
  final Widget? linkText;

  CardDetailTitleAndSubTitleModel({
    this.labelText,
    this.titleText,
    this.linkText,
  });
}

class ManageCardAttributes {
  final CardRowHeaderModel? manageCardHeaderText;
  final List<CardRowHeaderModel>? manageCardData;

  ManageCardAttributes({
    this.manageCardHeaderText,
    this.manageCardData,
  });
}

class CardDetailRowModel {
  final String? titleText;
  final CardRowHeaderModel? manageCardHeaderText;

  CardDetailRowModel({this.titleText, this.manageCardHeaderText});
}

class CardRowHeaderModel {
  /// The text to show on the header. This takes precedence over the [labelTextAttributes]
  final String? labelText;

  /// Attributes for the header to be rendered as [PSPageHeaderTextUnderIconWidget]
  final PSPageHeaderTextUnderIconWidgetAttributes? labelTextAttributes;

  final String? iconPath;
  final String? secondIconPath;
  final Function()? iconAction;
  final PSPadding? padding;
  final bool visible;
  final Color? background;
  CardRowHeaderModel({
    this.labelText,
    this.labelTextAttributes,
    this.iconPath,
    this.secondIconPath,
    this.padding,
    this.iconAction,
    this.visible = true,
    this.background,
  });
}
