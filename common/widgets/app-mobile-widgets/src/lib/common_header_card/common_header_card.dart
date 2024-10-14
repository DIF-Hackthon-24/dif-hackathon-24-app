import 'package:flutter/material.dart';

class _Constant {
  _Constant._();
  static const Color backGroundColor = Color(0xFFFFFFFF);
  static const Color boarderColor = Color(0xffC7BDBA);

  static const double boarderWidth = 0.5;
  static const double boarderRadius = 10;
  static const double contentPadding = 20;
  static const double paddingBetweenContent = 15;
}

class CommonHeaderCardAttributes {
  final bool isRTL;

  CommonHeaderCardAttributes({
    required this.isRTL,
  });
}

class CommonHeaderCard extends StatelessWidget {
  const CommonHeaderCard({
    Key? key,
    required this.attributes,
    required this.trailing,
    required this.leading,
    this.backGroundColor = _Constant.backGroundColor,
    this.boarderColor = _Constant.boarderColor,
    this.boarderWidth = _Constant.boarderWidth,
    this.boarderRadius = _Constant.boarderRadius,
    this.contentPadding = _Constant.contentPadding,
    this.paddingBetweenContent = _Constant.paddingBetweenContent,
  }) : super(key: key);

  final CommonHeaderCardAttributes attributes;
  final Widget trailing;
  final Widget leading;
  final Color backGroundColor;
  final Color boarderColor;
  final double boarderWidth;
  final double boarderRadius;
  final double contentPadding;
  final double paddingBetweenContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: boarderColor,
          width: boarderWidth,
        ),
        color: backGroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(boarderRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(contentPadding),
        child: Row(
          children: [
            leading,
            SizedBox(
              width: paddingBetweenContent,
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
