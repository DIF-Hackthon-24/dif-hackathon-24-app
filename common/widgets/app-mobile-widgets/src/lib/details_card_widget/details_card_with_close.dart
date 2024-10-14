import 'package:flutter/material.dart';

typedef WidgetBuilder = Widget Function(
  BuildContext context,
);

class _Constants {
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const double zero = 0;
  static const double four = 4;
  static const double five = 5;
  static const double eight = 8;
  static const double ten = 10;
  static const double twenty = 20;
  static const double forty = 40;
  static const double shadowRadius = 2.5;
}

/// customizable card with close button and auto resize with respect to content
class DetailsCardWithClose extends StatelessWidget {
  const DetailsCardWithClose({
    Key? key,
    required this.contentBuilder,
    this.closeWidget,
    this.closeWidgetAlign,
    this.closeWidgetBottomPosition = _Constants.zero,
    this.closeWidgetTopPosition = _Constants.zero,
    this.closeWidgetLeftPosition = _Constants.zero,
    this.closeWidgetRightPosition = _Constants.zero,
    this.cardColor = _Constants.white,
    this.borderRadius = _Constants.ten,
    this.shadowColor = _Constants.grey,
    this.horizontalPadding = _Constants.eight,
    this.shadowRadius = _Constants.shadowRadius,
    this.offsetDx = _Constants.zero,
    this.offsetDy = _Constants.four,
    this.topContentPadding = _Constants.twenty,
    this.bottomContentPadding = _Constants.twenty,
    this.leftContentPadding = _Constants.twenty,
    this.rightContentPadding = _Constants.forty,
  }) : super(key: key);

  final double borderRadius;
  final double horizontalPadding;
  final double closeWidgetTopPosition;
  final double closeWidgetBottomPosition;
  final double closeWidgetLeftPosition;
  final double closeWidgetRightPosition;
  final double topContentPadding;
  final double bottomContentPadding;
  final double leftContentPadding;
  final double rightContentPadding;
  final double shadowRadius;
  final double offsetDx;
  final double offsetDy;
  final Color cardColor;
  final Color shadowColor;
  final Widget? closeWidget;
  final WidgetBuilder contentBuilder;
  final AlignmentGeometry? closeWidgetAlign;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Padding(
            padding: EdgeInsets.all(
              _Constants.ten,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: shadowRadius,
                    offset: Offset(offsetDx, offsetDy),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: topContentPadding,
                  bottom: bottomContentPadding,
                ),
                child: contentBuilder(context),
              ),
            ),
          ),

          /// if the card has a close button then that will be positioned accordingly
          /// can have any type od close widget
          /// works with both position and align
          if (closeWidgetAlign != null && closeWidget != null)
            Align(
              alignment: closeWidgetAlign!,
              child: Container(
                padding: EdgeInsets.only(
                  left: _Constants.ten,
                  right: _Constants.ten,
                  top: _Constants.five,
                ),
                child: closeWidget,
              ),
            ),
          if (closeWidget != null && closeWidgetAlign == null)
            Positioned.fill(
              top: closeWidgetTopPosition,
              right: closeWidgetRightPosition,
              bottom: closeWidgetBottomPosition,
              left: closeWidgetLeftPosition,
              child: closeWidget!,
            ),
        ],
      ),
    );
  }
}
