// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/buttons.dart';

/// A button that has simple styling and changes colour when pressed.
///
///
// Karl's note: We don't utilise the [PSInPlaceButton] with a new style, as the text underline
// does not change colour with the button press as required by the design. Tried a few ways of getting that to
// work, e.g. underline via a Decorated Container, using the underline [TextStyle], etc. but no solution changed the underline
// colour when the button was pressed.
class PSLinkButton extends StatefulWidget {
  late final String text;
  final VoidCallback? onPressed;

  /// The variant controls the button colours and can be `primary`, the default,
  /// `secondary` and `tertiary`
  final PSButtonThemeVariant variant;

  PSLinkButton({
    Key? key,
    required String text,
    required this.onPressed,
    this.variant = PSButtonThemeVariant.primary,
  }) : super(key: key) {
    this.text = text.toUpperCase();
  }

  @override
  State<StatefulWidget> createState() => _PSLinkButtonState();
}

class _PSLinkButtonState extends State<PSLinkButton> {
  var _isPressed = false;

  bool get _isDisabled => widget.onPressed == null;
  bool get _isNotDisabled => !_isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('_PSLinkButton_GestureDetector'),
      onTapDown: (details) => setState(() => _isPressed = true && _isNotDisabled),
      onTapUp: (details) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: Container(
        key: Key('_PSLinkButton_Container'),
        decoration: BoxDecoration(
          border: Border(),
        ),
        child: Text(
          widget.text.toUpperCase(),
          key: Key('_PSLinkButton_Text'),
        ),
      ),
    );
  }
}
