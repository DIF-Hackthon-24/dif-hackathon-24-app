import 'package:flutter/material.dart';

class PSCheckbox extends StatelessWidget {
  final bool? value;
  final ValueSetter<bool?> onChanged;
  final double sizeScale = 1.3;
  final Color? color;
  final OutlinedBorder? shape;
  final Key customKey;

  const PSCheckbox({
    this.customKey = const Key('check_box'),
    this.value,
    this.shape,
    required this.onChanged,
    this.color,
  }) : super(key: customKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.scale(
        scale: sizeScale,
        child: Checkbox(
          key: customKey,
          tristate: true,
          value: value,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
          onChanged: onChanged,
          activeColor: color,
          side: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
