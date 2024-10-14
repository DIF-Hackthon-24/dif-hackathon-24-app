import 'package:flutter/material.dart';

class _Constant {
  _Constant._();
  static const Color backGroundColor = Color(0xFFFFFFFF);
  static const Color borderColor = Colors.transparent;

  static const double borderWidth = 0.5;
  static const double borderRadius = 10;
  static const double contentPadding = 20;
  static const double paddingBetweenContent = 15;
  static const Color shadowColor = Colors.transparent;
  static const double blurRadius = 2;
  static const double offsetX = 0;
  static const double offsetY = -1;
}

class CommonCardAttributes {
  final bool isRTL;

  CommonCardAttributes({
    this.isRTL = false,
  });
}

class CommonCard extends StatelessWidget {
  const CommonCard({
    Key? key,
    this.attributes,
    required this.child,
    this.backGroundColor = _Constant.backGroundColor,
    this.borderColor = _Constant.borderColor,
    this.borderWidth = _Constant.borderWidth,
    this.borderRadius = _Constant.borderRadius,
    this.contentPadding = _Constant.contentPadding,
    this.shadowColor = _Constant.shadowColor,
    this.blurRadius = _Constant.blurRadius,
    this.offsetX = _Constant.offsetX,
    this.offsetY = _Constant.offsetY,
    this.paddingBetweenContent = _Constant.paddingBetweenContent,
  }) : super(key: key);

  final CommonCardAttributes? attributes;
  final Widget child;
  final Color backGroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double contentPadding;
  final double paddingBetweenContent;
  final Color shadowColor;
  final double blurRadius;
  final double offsetX;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: backGroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
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
      child: Padding(
        padding: EdgeInsets.all(contentPadding),
        child: child,
      ),
    );
  }
}
