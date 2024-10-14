import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension StringExtentions on String {
  String get iconPath => split(':').first;

  String? get iconPackage => split(':').last;

  SvgPicture get toSvg {
    final list = split(':');
    if (list.length > 1) {
      return SvgPicture.asset(
        list[1],
        package: list[0],
      );
    }
    return SvgPicture.asset(list.first);
  }

  SvgPicture getSvg({Color? color, Size? size}) {
    final list = split(':');
    if (list.length > 1) {
      return SvgPicture.asset(
        list[1],
        key: Key('getSvgSvgPicture'),
        package: list[0],
        theme: color != null ?SvgTheme(currentColor: color,) : null,
        // color: color,
        width: size?.width,
        height: size?.height,
      );
    }
    return SvgPicture.asset(
      list.first,
      key: Key('getSvgFirstSvgPicture'),
    );
  }

  String replaceMiddleNumbers() {
    var newNumber = this;
    String replaceCharAt(String oldString, int index, String newChar) {
      return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
    }

    for (var i = 3; i < length - 4; i++) {
      newNumber = replaceCharAt(newNumber, i, '*');
    }

    return newNumber;
  }
}
