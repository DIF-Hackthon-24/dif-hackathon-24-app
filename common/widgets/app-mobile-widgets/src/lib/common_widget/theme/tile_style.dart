import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

enum TileStyle {
  lightBlue,
  midnightBlue,
  sand,
  lightPink,
}

@immutable
class TileStyleData {
  static final palette = PSTheme().themeData.colorPalette!;

  final Color bgColor;
  final Color titleColor;
  final Color iconColor;
  final Color buttonColor;

  TileStyleData({
    required this.bgColor,
    required this.titleColor,
    required this.iconColor,
    required this.buttonColor,
  });

  factory TileStyleData.withStyle(TileStyle style) {
    switch (style) {
      case TileStyle.lightBlue:
        return TileStyleData(
          bgColor: palette.panelColorPrimary.toColor(),
          titleColor: palette.secondary.toColor(),
          iconColor: palette.tertiary.toColor(),
          buttonColor: palette.tertiary.toColor(),
        );
      case TileStyle.midnightBlue:
        return TileStyleData(
          bgColor: palette.secondary.toColor(),
          titleColor: palette.quaternary.toColor(),
          iconColor: palette.denary.toColor(),
          buttonColor: palette.denary.toColor(),
        );
      case TileStyle.sand:
        return TileStyleData(
          bgColor: palette.denary.toColor(),
          titleColor: palette.secondary.toColor(),
          iconColor: palette.tertiary.toColor(),
          buttonColor: palette.tertiary.toColor(),
        );
      case TileStyle.lightPink:
        return TileStyleData(
          bgColor: palette.quaternary.toColor(),
          titleColor: palette.secondary.toColor(),
          iconColor: palette.tertiary.toColor(),
          buttonColor: palette.tertiary.toColor(),
        );
    }
  }
}
