import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_library/common_widget/enums/input_form_field_type.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';

class InputFormFieldsUIAttribute {
  InputFormFieldType type;

  String? helper;

  /// [placeholder] should be hint. NB-8784 rename to match Flutter TextField.
  String? placeholder;

  String? label;
  String value;
  String? header;
  String? iconPath;
  String? errorMessage;
  Country? selectedCountry;
  Function(String)? validateInput;
  Function(String)? onValuePicked;
  Function(String? value, int)? validator;
  Function(String, InputFormFieldType, int) onDoneEditing;
  bool isValid;
  bool isRequired;
  Function()? onDelete;
  String? deleteText;
  List<String>? dropDownValues;
  VoidCallback? onTap;
  TextInputType keyboardType;
  Color? backgroundColor;
  String? validIconPath;
  int maxLines;
  int? maxLength;
  bool readOnly;
  String? prefixText;
  List<TextInputFormatter>? formatters;
  String? key;
  FocusNode? focusNode;
  bool? showHint;
  String? hintText;
  int? minLength;
  String? validationRegex;
  String? example;
  TextUIDataModel? textFieldBottomText;
  String? filePath;
  bool? isSelected;
  Function(bool)? onSwitch;

  /// A unique id for this field. If not specified, defaults to the [type] index
  late int fieldId;

  /// The name of the custom field,
  String? customKey;

  // Map of arguments to be passed to underlying components
  Map<String, dynamic>? arguments;

  InputFormFieldsUIAttribute({
    required this.type,
    this.helper,
    this.placeholder,
    this.onValuePicked,
    this.label,
    required this.value,
    this.header,
    this.selectedCountry,
    this.onDelete,
    this.deleteText,
    this.iconPath,
    this.validateInput,
    required this.onDoneEditing,
    this.isValid = false,
    this.validator,
    this.isRequired = false,
    this.errorMessage,
    this.dropDownValues,
    this.validIconPath,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.backgroundColor,
    this.maxLength,
    this.readOnly = false,
    int? fieldId,
    this.customKey,
    this.prefixText,
    this.formatters,
    this.focusNode,
    this.key,
    this.showHint,
    this.hintText,
    this.arguments,
    this.minLength,
    this.example,
    this.validationRegex,
    this.textFieldBottomText,
    this.filePath,
    this.isSelected = false,
    this.onSwitch,
  }) : fieldId = fieldId ?? type.index;
}
