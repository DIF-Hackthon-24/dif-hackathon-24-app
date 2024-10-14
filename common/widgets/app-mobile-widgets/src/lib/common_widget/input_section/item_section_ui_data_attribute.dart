import 'package:widget_library/common_widget/input_field/input_form_fields_data_attribute.dart';
import 'package:widget_library/common_widget/input_section/input_section_header_ui_attribute.dart';

class ItemSectionUIDataAttribute {
  InputSectionHeaderUIDataAttribute? header;
  List<InputFormFieldsUIAttribute> formFields;
  int itemId;
  bool showItemHeader;

  ItemSectionUIDataAttribute({
    this.header,
    this.formFields = const [],
    this.itemId = 0,
    this.showItemHeader = false,
  });
}
