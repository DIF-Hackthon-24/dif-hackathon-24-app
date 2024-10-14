import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/enums/input_form_field_section_type.dart';
import 'package:widget_library/common_widget/input_section/item_section_ui_data_attribute.dart';

import 'input_section_header_ui_attribute.dart';

class InputSectionUIDataAttribute {
  InputFormFieldSectionType type;
  InputSectionHeaderUIDataAttribute? header;
  List<ItemSectionUIDataAttribute> itemFields;
  Function(InputFormFieldSectionType) onClick;
  bool isExpanded;
  bool showExpansion;
  Color? arrowIconColor;
  Function? onDelete;

  InputSectionUIDataAttribute({
    required this.type,
    required this.header,
    this.itemFields = const [],
    this.isExpanded = false,
    this.showExpansion = true,
    required this.onClick,
    this.arrowIconColor,
    this.onDelete,
  });
}
