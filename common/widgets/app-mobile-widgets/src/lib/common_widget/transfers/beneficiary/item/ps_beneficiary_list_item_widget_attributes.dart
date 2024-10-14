import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/cornered_icon_button.dart';
import 'package:widget_library/common_widget/list/ps_slidable_list_model.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/padding.dart';

enum PSBeneficiaryListIconType { circle, cornered, circleWithBorder, assetCircle }

enum PSBeneficiaryListItemWidgetType {
  lineItem,
  header,
}

@immutable
class PSBeneficiaryListItemIconAttributes {
  final PSBeneficiaryListIconType type;
  final TextUIDataModel? iconTitle;
  final Color? background;
  final String? path;
  final double? radius;
  final double height;
  final double width;
  final PSPadding? padding;
  final ButtonType buttonType;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;

  PSBeneficiaryListItemIconAttributes({
    this.type = PSBeneficiaryListIconType.circle,
    this.path,
    this.radius,
    this.padding,
    this.height = 60,
    this.width = 60,
    this.background = const Color(0xFFF5F6F7),
    this.iconTitle,
    this.buttonType = ButtonType.text,
    this.buttonStyle,
    this.onPressed,
  });
}

@immutable
class PSBeneficiaryListItemWidgetAttributes {
  final PSBeneficiaryListItemWidgetType type;
  final PSBeneficiaryListItemIconAttributes? iconAttributes;
  final TextUIDataModel title;
  final TextUIDataModel? subTitle;
  final TextUIDataModel? value;
  final Widget? indicator;
  final VoidCallback? onTap;
  final PSPadding? contentPadding;
  final double cardCornerRadius;
  final List<PSSlidableListActionAttribute>? slidableActions;

  PSBeneficiaryListItemWidgetAttributes({
    this.type = PSBeneficiaryListItemWidgetType.lineItem,
    this.iconAttributes,
    required this.title,
    this.subTitle,
    this.value,
    this.indicator,
    this.onTap,
    this.contentPadding,
    this.cardCornerRadius = 0,
    this.slidableActions,
  });

  PSBeneficiaryListItemWidgetAttributes copyWith({
    PSBeneficiaryListItemWidgetType type = PSBeneficiaryListItemWidgetType.lineItem,
    PSBeneficiaryListItemIconAttributes? iconAttributes,
    required TextUIDataModel title,
    TextUIDataModel? subTitle,
    TextUIDataModel? value,
    Widget? indicator,
    Function()? onTap,
    PSPadding? contentPadding,
    double? cardElevation,
    double? cardCornerRadius,
    Color? backgroundColor,
  }) =>
      PSBeneficiaryListItemWidgetAttributes(
        type: type,
        iconAttributes: iconAttributes ?? this.iconAttributes,
        title: title,
        subTitle: subTitle ?? this.subTitle,
        value: value ?? this.value,
        indicator: indicator ?? this.indicator,
        onTap: onTap ?? this.onTap,
        contentPadding: contentPadding ?? this.contentPadding,
        cardCornerRadius: cardCornerRadius ?? this.cardCornerRadius,
        slidableActions: slidableActions,
      );
}
