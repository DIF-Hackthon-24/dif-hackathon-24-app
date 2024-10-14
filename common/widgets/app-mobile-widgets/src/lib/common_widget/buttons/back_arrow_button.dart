import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? color;
  final IconData? customIcon;
  final double? size;

  const BackArrowButton({
    Key? key,
    this.onPressed,
    this.color,
    this.customIcon,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('BackArrowButton_IconButton'),
      icon: Icon(
        customIcon ?? Icons.arrow_back,
        key: Key('BackArrowButtonIcon'),
        color: color ?? Theme.of(context).secondaryHeaderColor,
        size: size,
      ),
      onPressed: onPressed ??
          () {
            Navigator.of(context).pop();
          },
    );
  }
}
