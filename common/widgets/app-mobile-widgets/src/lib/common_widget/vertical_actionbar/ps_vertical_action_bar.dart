import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/buttons.dart';
import 'package:widget_library/common_widget/buttons/cornered_icon_button.dart';

/// The standard radius of the rounded box button border
const double _PSverticalActionBarButtonPadding = 12.0;

class PSVerticalActionBarNode {
  final Widget content;
  final bool isTop;

  PSVerticalActionBarNode({
    required this.content,
    required this.isTop,
  });
}

/// Action bar presenting [PSCorneredIconButton] list vertically
///
/// [PSVerticalActionBar] adjusts it's height according to
/// action elements quantity and ancestor widget height.
/// All actions are built of [PSCorneredIconButton] widget
/// that represents a center icon with
/// the primary background color of the theme.
class PSVerticalActionBar extends StatelessWidget {
  final List<PSVerticalActionBarNode> actions;

  /// Represents the height of the object to which vertical action
  /// bar is sticked to and lays-out next to.
  final double? fixedHeight;

  final String? themeName;

  const PSVerticalActionBar({
    Key? key,
    required this.actions,
    this.fixedHeight,
    this.themeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: Key('PSVerticalActionBar_Container'),
      height: fixedHeight,
      child: Column(
        key: Key('PSVerticalActionBar_Column'),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            key: Key('PSVerticalActionBar_ChildrenColumn'),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var action in actions.where((e) => e.isTop))
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: _PSverticalActionBarButtonPadding,
                  ),
                  child: action.content,
                ),
            ],
          ),
          Column(
            key: Key('PSVerticalActionBar_ChildColumn'),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (var action in actions.where((e) => !e.isTop))
                Padding(
                  padding: const EdgeInsets.only(
                    top: _PSverticalActionBarButtonPadding,
                  ),
                  child: action.content,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionModel {
  final String? title;
  final String? iconUri;
  final Function? action;
  final PSButtonThemeVariant? variant;
  final Alignment buttonAlignment;
  final PSButtonOverlayStyle buttonStyle;
  final Color? foregroundNormalOverwriteColor;
  final Color? borderNormalOverwriteColor;
  final Color? overlayNormalOverwriteColor;
  final Color? backgroundNormalOverwriteColor;
  final bool? isButtonVisible;
  final ButtonStyle? elevatedButtonStyle;

  ActionModel({
    this.title,
    this.iconUri,
    this.action,
    this.variant,
    this.buttonAlignment = Alignment.topCenter,
    this.buttonStyle = PSButtonOverlayStyle.rounded,
    this.backgroundNormalOverwriteColor,
    this.borderNormalOverwriteColor,
    this.foregroundNormalOverwriteColor,
    this.overlayNormalOverwriteColor,
    this.isButtonVisible = true,
    this.elevatedButtonStyle,
  });

  ActionModel copyWith({
    String? title,
    String? iconUri,
    Function? action,
    PSButtonThemeVariant? variant,
    Alignment? buttonAlignment,
    PSButtonOverlayStyle? buttonStyle,
    Color? foregroundNormalOverwriteColor,
    Color? borderNormalOverwriteColor,
    Color? overlayNormalOverwriteColor,
    Color? backgroundNormalOverwriteColor,
    bool? isButtonVisible,
    ButtonStyle? elevatedButtonStyle,
  }) {
    return ActionModel(
      title: title ?? this.title,
      iconUri: iconUri ?? this.iconUri,
      action: action ?? this.action,
      variant: variant ?? this.variant,
      buttonAlignment: buttonAlignment ?? this.buttonAlignment,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      backgroundNormalOverwriteColor: backgroundNormalOverwriteColor ?? this.backgroundNormalOverwriteColor,
      borderNormalOverwriteColor: borderNormalOverwriteColor ?? this.borderNormalOverwriteColor,
      foregroundNormalOverwriteColor: foregroundNormalOverwriteColor ?? this.foregroundNormalOverwriteColor,
      overlayNormalOverwriteColor: overlayNormalOverwriteColor ?? this.overlayNormalOverwriteColor,
      isButtonVisible: isButtonVisible ?? this.isButtonVisible,
      elevatedButtonStyle: elevatedButtonStyle ?? this.elevatedButtonStyle,
    );
  }
}
