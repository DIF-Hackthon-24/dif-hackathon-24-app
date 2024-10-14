import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';

class SecureTextFieldAttributes {
  TextUIDataModel header;
  TextUIDataModel? hint;
  Function(String password) onTextChanged;
  Function()? onSuffixIconTap;
  String? showHideIconPath;
  String obscuringCharacter;
  bool isSecure;
  bool hideFloatingLabel;

  SecureTextFieldAttributes({
    required this.header,
    this.hint,
    required this.onTextChanged,
    this.showHideIconPath,
    this.onSuffixIconTap,
    this.obscuringCharacter = '*',
    this.isSecure = true,
    this.hideFloatingLabel = false,
  });
}
