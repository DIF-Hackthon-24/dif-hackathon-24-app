import 'dart:ui';

class SquarePanelDetailAttributes {
  final Function() onTap;
  final String? filePath;
  String? uploadDocumentKey;
  String? iconPath;
  Color? iconColor;
  double? iconSize;
  String? subtitle;
  String? bottomText;
  String? topRightIconPath;
  String? topLeftText;
  String? topExplainerText;
  Color? backgroundColor;
  String? documentSide;

  SquarePanelDetailAttributes({
    required this.onTap,
    this.backgroundColor,
    this.filePath,
    this.subtitle,
    this.bottomText,
    this.iconPath,
    this.topLeftText,
    this.topExplainerText,
    this.topRightIconPath,
    this.documentSide,
  });
}
