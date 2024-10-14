import 'package:flutter/material.dart';

class _Constant {
  _Constant._();
  static const double tilePaddingTop = 10;
  static const double tilePaddingBottom = 0;
  static const double tilePaddingLeft = 0;
  static const double tilePaddingRight = 0;

  static const Color tileBorderColor = Color(0xFFFFFFFF);
  static const double tileBorderWidth = 0.5;
  static const double tileBorderRadius = 10;
  static const Color tileBackgroundColor = Color(0xFFFFFFFF);
  static const double tileContentPadding = 20;
}

class CommonDetailsListTileAttributes {
  final bool isRTL;
  final bool isTablet;

  CommonDetailsListTileAttributes({
    this.isRTL = false,
    this.isTablet = false,
  });
}

class CommonDetailsListTile extends StatelessWidget {
  const CommonDetailsListTile({
    Key? key,
    required this.attributes,
    this.tilePaddingTop = _Constant.tilePaddingTop,
    this.tilePaddingBottom = _Constant.tilePaddingBottom,
    this.tilePaddingLeft = _Constant.tilePaddingLeft,
    this.tilePaddingRight = _Constant.tilePaddingRight,
    this.tileBorderColor = _Constant.tileBorderColor,
    this.tileBorderWidth = _Constant.tileBorderWidth,
    this.tileBorderRadius = _Constant.tileBorderRadius,
    this.tileBackgroundColor = _Constant.tileBackgroundColor,
    this.tileContentPadding = _Constant.tileContentPadding,
    this.commonDetailTileTitle,
    this.commonDetailsTileValue,
    this.commonDetailsTileImage,
  }) : super(key: key);

  final CommonDetailsListTileAttributes attributes;

  final double tilePaddingTop;
  final double tilePaddingBottom;
  final double tilePaddingLeft;
  final double tilePaddingRight;

  final Color tileBorderColor;
  final double tileBorderWidth;
  final double tileBorderRadius;
  final Color tileBackgroundColor;

  final double tileContentPadding;

  final Widget? commonDetailsTileImage;
  final Widget? commonDetailTileTitle;
  final Widget? commonDetailsTileValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: tilePaddingTop,
        bottom: tilePaddingBottom,
        left: tilePaddingLeft,
        right: tilePaddingRight,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: tileBorderColor,
            width: tileBorderWidth,
          ),
          color: tileBackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(tileBorderRadius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(tileContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (commonDetailTileTitle != null) commonDetailTileTitle!,
              if (commonDetailsTileValue != null) commonDetailsTileValue!,
              if (commonDetailsTileImage != null)
                SizedBox(
                  height: 11,
                ),
              if (commonDetailsTileImage != null) commonDetailsTileImage!,
            ],
          ),
        ),
      ),
    );
  }
}
