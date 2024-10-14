import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class PsFieldInputDecoration extends InputDecoration {
  PsFieldInputDecoration({
    required BuildContext context,
    Color? bgColor,
    String? hintText,
    TextStyle? hintStyle,
    String? labelText,
    TextStyle? labelStyle,
    Widget? suffix,
    Widget? suffixIcon,
    String? helperText,
    String? errorText,
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.auto,
    InputBorder? border,
    bool filled = true,
    bool alignLabelWithHint = false,
    EdgeInsetsGeometry? contentPadding,
    int? errorMaxLines = 4,
  }) : super(
          fillColor: bgColor ?? PSTheme().defaultThemeData.textFieldBackgroundColor?.toColor(),
          suffix: suffix,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: labelStyle ?? Theme.of(context).inputDecorationTheme.hintStyle,
          hintStyle: hintStyle,
          hintText: hintText,
          alignLabelWithHint: alignLabelWithHint,
          helperText: helperText,
          errorText: errorText,
          errorMaxLines: errorMaxLines,
          filled: filled,
          floatingLabelBehavior: floatingLabelBehavior,
          // errorBorder: OutlinedBorder(
          //   borderSide: BorderSide(
          //     color: Theme.of(context).inputDecorationTheme.errorStyle!.color!,
          //   ),
          // ),
          border: border ?? OutlinedBorder(borderSide: BorderSide.none),
          contentPadding: contentPadding,
        );
}

/// A mixture of a filled textfield with outlined border.
/// It avoids floating the label to the border but can render a full border for error conditions
class OutlinedBorder extends OutlineInputBorder {
  const OutlinedBorder({
    BorderSide borderSide = const BorderSide(),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  }) : super(borderSide: borderSide, borderRadius: borderRadius);

  @override
  bool get isOutline => false;

  // Override paint to remove the gaps and extent
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    super.paint(canvas, rect, gapStart: 0, gapExtent: 0, gapPercentage: gapPercentage, textDirection: textDirection);
  }
}
