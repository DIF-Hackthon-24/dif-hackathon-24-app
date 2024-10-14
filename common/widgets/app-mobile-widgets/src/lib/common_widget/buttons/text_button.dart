import 'package:core/translation/app_localization.dart';
import 'package:flutter/material.dart';

class PSTextButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final Alignment? alignment;
  final ButtonStyle? textButtonStyle;

  const PSTextButton({
    Key? key,
    this.onPressed,
    this.child,
    required this.text,
    this.color,
    this.textStyle,
    this.alignment,
    this.textButtonStyle,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: Key('PSTextButton_TextButton'),
      onPressed: onPressed,
      style: textButtonStyle ?? Theme.of(context).textButtonTheme.style,
      child: child ?? Text(_localizedText(context, text), key: Key('PSTextButton_Text'), style: textStyle),
    );
  }

  String _localizedText(
    BuildContext context,
    String text,
  ) {
    if (text.toUpperCase() == text) {
      return AppLocalizations.of(context)!.translate(text.toLowerCase()).toUpperCase();
    } else {
      return AppLocalizations.of(context)!.translate(text);
    }
  }
}
