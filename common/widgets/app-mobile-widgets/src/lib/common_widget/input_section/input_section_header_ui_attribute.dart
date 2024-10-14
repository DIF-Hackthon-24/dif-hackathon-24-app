import 'package:flutter/widgets.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class InputSectionHeaderUIDataAttribute {
  String? prefix;
  String title;
  PSTextStyleVariant? textStyleVariant;
  String? deleteItemIconPath;
  final void Function(BuildContext context, int index)? onItemDelete;
  String? iconPath;
  String? iconPathSelected;
  bool isOptional;

  InputSectionHeaderUIDataAttribute({
    this.prefix,
    required this.title,
    this.textStyleVariant,
    this.deleteItemIconPath,
    this.onItemDelete,
    this.iconPath,
    this.iconPathSelected,
    this.isOptional = false,
  });
}
