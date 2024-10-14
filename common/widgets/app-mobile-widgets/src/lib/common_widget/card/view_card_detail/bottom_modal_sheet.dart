import 'package:flutter/material.dart';
import 'package:widget_library/padding.dart';

class Constants {
  static const borderRadius = 22.0;
  static const borderPadding = 32.0;
  static const horizontalPadding = 16.0;
  static const backgroundColor = Colors.white;
  static const paddingBottomCarousel = 62.0;
  static const paddingRightCarousel = 30.0;
}

Widget showActionSheet(Widget child, {PSPadding? padding}) {
  final radius = Radius.circular(Constants.borderRadius);

  return Wrap(
    key: Key('showActionSheet_Wrap'),
    children: [
      Container(
        key: Key('showActionSheet_Container'),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: padding?.toEdgeInsets() ??
            EdgeInsets.only(
              top: Constants.borderPadding,
              left: Constants.borderPadding,
              bottom: Constants.paddingBottomCarousel,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
          ),
          color: Constants.backgroundColor,
        ),
        child: child,
      ),
    ],
  );
}
