import 'package:flutter/material.dart';

class BottomStickySectionAttributes {
  final bool isRTL;
  final double height;
  BottomStickySectionAttributes({
    this.isRTL = false,
    required this.height,
  });
}

class _Constant {
  _Constant._();
  static const Color buttonBackgroundColor = Color(0xffF4F2F1);
  static const Color shadowColor = Color(0x93634B00);
  static const double blurRadius = 2;
  static const double offsetX = 0;
  static const double offsetY = -1;
  static const double buttonPadding = 20;
}

class BottomStickySection extends StatelessWidget {
  const BottomStickySection({
    Key? key,
    required this.attributes,
    required this.child,
    this.backgroundColor = _Constant.buttonBackgroundColor,
    this.shadowColor = _Constant.shadowColor,
    this.blurRadius = _Constant.blurRadius,
    this.offsetX = _Constant.offsetX,
    this.offsetY = _Constant.offsetY,
    this.buttonPadding = _Constant.buttonPadding,
  }) : super(key: key);

  final BottomStickySectionAttributes attributes;
  final Widget child;
  final Color backgroundColor;
  final Color shadowColor;
  final double blurRadius;
  final double offsetX;
  final double offsetY;
  final double buttonPadding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: shadowColor,
              blurRadius: blurRadius,
              offset: Offset(
                offsetX,
                offsetY,
              ),
            ),
          ],
        ),
        height: attributes.height,
        child: Padding(
          padding: EdgeInsets.all(buttonPadding),
          child: child,
        ),
      ),
    );
  }
}
