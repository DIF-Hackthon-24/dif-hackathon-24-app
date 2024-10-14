import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Gets an SVG icon with optional colour and size
@Deprecated('Use PSImage')
SvgPicture getSvg(
  String iconPath, {
  double? width,
  double? height,
  Color? color,
  BoxFit? boxFit,
  AlignmentGeometry? alignment,
}) {
  final list = iconPath.split(':');
  if (list.length > 1) {
    return SvgPicture.asset(
      list[1],
      package: list[0],
      width: width,
      height: height,
      color: color,
      alignment: alignment ?? Alignment.center,
      fit: boxFit ?? BoxFit.contain,
    );
  }
  return SvgPicture.asset(
    list.first,
    width: width,
    height: height,
    color: color,
    fit: boxFit ?? BoxFit.contain,
  );
}

@Deprecated('Use PSImage')
Image getPng(
  String iconPath, {
  double? width,
  double? height,
  Color? color,
}) {
  final list = iconPath.split(':');
  if (list.length > 1) {
    return Image.asset(
      list[1],
      package: list[0],
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }

  return Image.asset(list.first);
}

ImageProvider getImageProviderForPath(String iconPath) {
  final list = iconPath.split(':');
  if (list.length > 1) {
    return AssetImage(list[1], package: list[0]);
  }

  return AssetImage(list.first);
}

Image getGif(
  String iconPath, {
  double? width,
  double? height,
}) {
  final list = iconPath.split(':');
  if (list.length > 1) {
    return Image.asset(
      list[1],
      package: list[0],
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }

  return Image.asset(list.first);
}

enum ImageType {
  Svg,
  Png,
}
