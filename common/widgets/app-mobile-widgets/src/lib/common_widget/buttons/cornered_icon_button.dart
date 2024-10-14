import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/buttons.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

/// The standard radius of the rounded box button border
const double _PScorneredIconButtonBorderRadius = 10.0;

/// The standard height of the rounded box button
const double _PScorneredIconButtonHeight = 48;

/// The compact height of the rounded box button
const double _PScorneredIconButtonCompactHeight = 40;

/// The standard width of the rounded box button
const double _PScorneredIconButtonWidth = 48;

enum ButtonType { icon, text }

class PSCorneredIconButton extends StatelessWidget {
  /// The image of the button displayed in the center
  final String? svgSource;
  final VoidCallback? onPressed;
  final Size? minimumSize;
  final Color? buttonColor;

  /// The variant controls the button colours and can be `primary`, the default,
  /// `secondary` and `tertiary`
  final PSButtonThemeVariant variant;

  /// Supported visual densities are `standard` and `compact` representing the
  /// Large and Small buttons in the design. Note that these do not fallback to
  /// the Material Visual Densities as the design does not follow those
  ///  guidelines.
  final VisualDensity visualDensity;

  /// To Change the button style from the default `rectangular` to `rounded`
  final PSButtonOverlayStyle buttonOverlayStyle;

  final ButtonType buttonType;

  final TextUIDataModel? buttonText;
  final bool isBorderEnabled;

  /// When not specified, the default theme from the context is used
  final String? themeName;

  final Color? foregroundNormalOverwriteColor;
  final Color? borderNormalOverwriteColor;
  final Color? overlayNormalOverwriteColor;
  final Color? backgroundNormalOverwriteColor;
  final ButtonStyle? buttonStyle;

  const PSCorneredIconButton({
    Key? key,
    this.svgSource,
    this.onPressed,
    this.minimumSize,
    this.buttonColor,
    this.variant = PSButtonThemeVariant.primary,
    this.buttonOverlayStyle = PSButtonOverlayStyle.rounded,
    this.visualDensity = VisualDensity.standard,
    this.buttonType = ButtonType.icon,
    this.buttonText,
    this.isBorderEnabled = true,
    this.themeName,
    this.backgroundNormalOverwriteColor,
    this.borderNormalOverwriteColor,
    this.foregroundNormalOverwriteColor,
    this.overlayNormalOverwriteColor,
    this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = _getButtonSize();
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ElevatedButton(
        key: key,
        onPressed: onPressed,
        style: buttonStyle ??
            ButtonStyle(
              elevation: _PSRoundedButtonDefaultElevation(0),
              minimumSize: ButtonStyleButton.allOrNull<Size>(size),
              shape: ButtonStyleButton.allOrNull<OutlinedBorder>(_getBorder()),
            ),
        child: getButtonContent(context),
      ),
    );
  }

  Widget getButtonContent(BuildContext context) =>
      (buttonType == ButtonType.icon) ? _getIcon(context) : _getButtonText();

  Widget _getButtonText() => (buttonText != null) ? PSText(text: buttonText!) : SizedBox.shrink();

  Container _getIcon(BuildContext context) {
    if (svgSource != null) {
      final theme = Theme.of(context);
      final themeColor = theme.elevatedButtonTheme.style?.textStyle?.resolve({MaterialState.disabled})?.color;
      var iconColor = themeColor ?? PSTheme().defaultThemeData.actionButtonIconColor.toColor();
      if (buttonStyle != null && buttonStyle!.foregroundColor != null) {
        iconColor = buttonStyle!.foregroundColor!.resolve({MaterialState.selected}) ?? iconColor;
      }
      return Container(
        key: Key('getIcon_Container'),
        width: _getButtonSize().width,
        height: _getButtonSize().height,
        child: Center(
          key: Key('getIcon_Center'),
          /* child: getSvg(
            svgSource!,
            color: iconColor,
          ), */
          child: PSImage(
            PSImageModel(
              iconPath: svgSource!,
              color: iconColor,
            ),
          ),
        ),
      );
    } else {
      return Container(
        key: Key('Container_GetIcon'),
      );
    }
  }

  OutlinedBorder _getBorder() {
    OutlinedBorder border;
    switch (buttonOverlayStyle) {
      case PSButtonOverlayStyle.rounded:
        border = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_PScorneredIconButtonBorderRadius),
          ),
        );
        break;
      default:
        border = const StadiumBorder();
    }
    return border;
  }

  Size _getButtonSize() {
    // Default the button sizes
    var height = minimumSize?.height ?? _PScorneredIconButtonHeight;
    final width = minimumSize?.width ?? _PScorneredIconButtonWidth;
    if (height == _PScorneredIconButtonHeight && visualDensity == VisualDensity.compact) {
      // Adjust the height for the visual density unless it has been
      // overriden by a specific height
      height = _PScorneredIconButtonCompactHeight;
    }
    return Size(width, height);
  }
}

// @immutable
// class _PSRoundedBoxButtonDefaultBackground extends MaterialStateProperty<Color?> with Diagnosticable {
//   _PSRoundedBoxButtonDefaultBackground(
//     this.primary,
//     this.pressed,
//     this.disabled,
//   );

//   final Color? primary;
//   final Color? pressed;
//   final Color? disabled;

//   @override
//   Color? resolve(Set<MaterialState> states) {
//     if (states.contains(MaterialState.disabled)) {
//       return disabled?.withOpacity(0.2);
//     }
//     if (states.contains(MaterialState.pressed)) {
//       return pressed;
//     }

//     return primary;
//   }
// }

// @immutable
// class _PSRoundedBoxButtonDefaultForeground extends MaterialStateProperty<Color?> with Diagnosticable {
//   _PSRoundedBoxButtonDefaultForeground(
//     this.onPrimary,
//     this.onSurface,
//     this.disabled,
//   );

//   final Color? onPrimary;
//   final Color? onSurface;
//   final Color? disabled;

//   @override
//   Color? resolve(Set<MaterialState> states) {
//     if (states.contains(MaterialState.disabled)) return disabled;
//     return onPrimary;
//   }
// }

// @immutable
// class _PSRoundedBoxButtonDefaultOverlay extends MaterialStateProperty<Color?> with Diagnosticable {
//   _PSRoundedBoxButtonDefaultOverlay(this.onPrimary, this.pressed);

//   final Color onPrimary;
//   final Color? pressed;

//   @override
//   Color? resolve(Set<MaterialState> states) {
//     if (states.contains(MaterialState.hovered)) {
//       return onPrimary.withOpacity(0.08);
//     }
//     if (states.contains(MaterialState.focused)) {
//       return onPrimary.withOpacity(0.24);
//     }
//     if (states.contains(MaterialState.pressed)) return pressed;
//     return null;
//   }
// }

@immutable
class _PSRoundedButtonDefaultElevation extends MaterialStateProperty<double> with Diagnosticable {
  _PSRoundedButtonDefaultElevation(this.elevation);

  final double elevation;

  @override
  double resolve(Set<MaterialState> states) {
    return elevation;
  }
}

// class _PSCorneredIconButtonBorderSide extends MaterialStateProperty<BorderSide> with Diagnosticable {
//   _PSCorneredIconButtonBorderSide(
//     this.onPrimary,
//     this.onDisabled,
//   );

//   final Color onPrimary;
//   final Color onDisabled;

//   @override
//   BorderSide resolve(Set<MaterialState> states) {
//     if (states.contains(MaterialState.disabled)) {
//       return BorderSide(
//         color: onDisabled,
//       );
//     }

//     return BorderSide(
//       color: onPrimary,
//       width: 2,
//     );
//   }
// }
