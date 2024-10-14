import 'package:core/translation/app_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/buttons.dart';
import 'package:widget_library/common_widget/constants.dart';
import 'package:widget_library/padding.dart';

/// A variant of the [PSDockedButton] that wraps the [ElevatedButton] and
/// restyles it rather then extending the [ButtonStyleButton]
///
class PSDockedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Size? minimumSize;
  final PSPadding? padding;
  final double cornerRadius;
  final TextStyle? textStyle;
  final double? buttonPadding;

  /// The variant controls the button colours and can be `primary`, the default,
  /// `secondary` and `tertiary`
  final PSButtonThemeVariant variant;
  final Color? buttonColor;

  PSDockedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.variant = PSButtonThemeVariant.primary,
    this.minimumSize,
    this.padding,
    this.buttonColor,
    this.cornerRadius = kCornerRadiusDockedButton,
    this.textStyle,
    this.buttonPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonSize = minimumSize ??
        Size(
          kMinWidthDockedButton,
          kMinHeightDockedButton,
        );
    return Padding(
      key: Key('PSDockedButton_Padding'),
      padding: (padding != null)
          ? EdgeInsets.fromLTRB(
              padding!.left,
              padding!.top,
              padding!.right,
              padding!.bottom,
            )
          : EdgeInsets.all(0),
      child: ElevatedButton(
        key: Key('PSDockedButton_ElevatedButton'),
        onPressed: onPressed,
        style: ButtonStyle(
          padding: buttonPadding != null ? MaterialStatePropertyAll(const EdgeInsets.all(5)) : null,
          elevation: _PSDockedButtonDefaultElevation(0),
          minimumSize: ButtonStyleButton.allOrNull<Size>(buttonSize),
          side: ButtonStyleButton.allOrNull<BorderSide>(BorderSide.none),
          shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                cornerRadius,
              ),
            ),
          ),
          backgroundColor: ButtonStyleButton.allOrNull<Color>(buttonColor),
        ),
        child: Text(
          AppLocalizations.of(context)!.translate(title),
          key: Key('PSDockedButton_Text'),
          style: textStyle,
        ),
      ),
    );
  }
}

@immutable
class _PSDockedButtonDefaultElevation extends MaterialStateProperty<double> with Diagnosticable {
  _PSDockedButtonDefaultElevation(this.elevation);

  final double elevation;

  @override
  double resolve(Set<MaterialState> states) {
    return elevation;
  }
}
