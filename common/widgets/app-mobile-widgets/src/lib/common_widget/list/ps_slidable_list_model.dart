import 'package:flutter/widgets.dart';

/// Attribute class to abstract properties of [IconSlideAction]
@immutable
class PSSlidableListActionAttribute {
  final String? caption;
  final String iconPath;
  final Color? iconColor;
  final Color? color;
  final VoidCallback? onTap;

  PSSlidableListActionAttribute({
    this.caption,
    required this.iconPath,
    this.iconColor,
    this.color,
    this.onTap,
  });
}
