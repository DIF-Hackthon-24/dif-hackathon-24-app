import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PSPadding {
  final double left;
  final double right;
  final double top;
  final double bottom;
  final double? width;
  final double height;

  const PSPadding({
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.width,
    this.height = 44,
  });

  const PSPadding.all(double padding)
      : left = padding,
        right = padding,
        top = padding,
        bottom = padding,
        width = 44,
        height = 44;

  const PSPadding.zero()
      : left = 0,
        right = 0,
        top = 0,
        bottom = 0,
        width = 44,
        height = 44;

  const PSPadding.only({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? width,
    double? height,
  })  : left = left ?? 0,
        right = right ?? 0,
        top = top ?? 0,
        bottom = bottom ?? 0,
        width = width ?? 0,
        height = height ?? 0;

  EdgeInsets toEdgeInsets() {
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }
}
