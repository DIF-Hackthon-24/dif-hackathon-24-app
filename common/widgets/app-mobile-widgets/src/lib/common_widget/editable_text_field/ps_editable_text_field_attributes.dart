import 'package:flutter/material.dart';
import 'package:widget_library/padding.dart';

class PsEditableTextFieldAttributes {
  String hint;
  String? initialValue;
  double fontSize;
  bool autoFocus;
  bool editable;
  Function(String) onSubmitSuccess;
  TextInputType type;
  // TextStyle textStyle;

  String? errorMessage;
  AsyncValidator? asyncValidator;
  bool inProgress;
  double progressRadius;

  String suffixIcon;
  Color? suffixIconColor;

  String? prefixIcon;
  PSPadding suffixPadding;
  PSPadding prefixPadding;
  bool validateInitialValue;

  PsEditableTextFieldAttributes({
    required this.hint,
    this.initialValue,
    this.fontSize = 17,
    this.autoFocus = true,
    // required this.textStyle,
    required this.editable,
    required this.onSubmitSuccess,
    this.type = TextInputType.text,
    this.errorMessage,
    this.asyncValidator,
    this.inProgress = false,
    this.suffixIcon = 'assets/images/ic_edit.svg',
    this.suffixPadding = const PSPadding(width: 23, height: 23, top: 8, left: 8, right: 8, bottom: 8),
    this.prefixPadding = const PSPadding(width: 50, top: 8, right: 15, bottom: 8),
    this.suffixIconColor,
    this.prefixIcon,
    this.progressRadius = 15,
    this.validateInitialValue = false,
  });
}

typedef AsyncValidator = Future<String?> Function(String);
