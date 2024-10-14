import 'package:core/translation/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PSTextFieldAttributes {
  final Function(String value)? onChanged;
  final String? labelText;
  final TextEditingController? textEditingController;
  final TextCapitalization? textCapitalization;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final int? maxLength;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputCounterWidgetBuilder? buildCounter;
  final bool enableInteractiveSelection;
  final bool enableSuggestions;
  final bool obscureText;
  final TextStyle? style;
  final bool autocorrect;
  final bool autoFocus;
  final String obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  final InputDecoration? decoration;
  final TextStyle? hintStyle;
  final double? fontSize;
  final Color? backgroundColor;
  final String? errorText;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final String? hint;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final Function()? onClick;

  PSTextFieldAttributes({
    Key? key,
    this.onChanged,
    this.labelText,
    this.textCapitalization,
    this.suffix,
    this.enabled,
    this.textEditingController,
    this.maxLength,
    this.buildCounter,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.enableInteractiveSelection = true,
    this.style,
    this.enableSuggestions = false,
    this.autocorrect = false,
    this.autoFocus = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.obscuringCharacter = '*',
    this.decoration,
    this.inputFormatters,
    this.hintStyle,
    this.fontSize,
    this.errorText,
    this.backgroundColor,
    this.onSubmitted,
    this.prefix,
    this.focusNode,
    this.cursorColor,
    this.hint,
    this.textInputAction,
    this.readOnly,
    this.onClick,
  });

  PSTextFieldAttributes copyWith({
    Function(String value)? onChanged,
    String? labelText,
    TextEditingController? textEditingController,
    TextCapitalization? textCapitalization,
    Widget? prefix,
    Widget? suffix,
    bool? enabled,
    int? maxLength,
    InputBorder? border,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputCounterWidgetBuilder? buildCounter,
    bool? enableInteractiveSelection,
    bool? enableSuggestions,
    bool? obscureText,
    bool? autocorrect,
    bool? autoFocus,
    String? obscuringCharacter,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    InputDecoration? decoration,
    double? fontSize,
    Color? backgroundColor,
    String? errorText,
    Function(String)? onSubmitted,
    FocusNode? focusNode,
    Color? cursorColor,
    String? hint,
    TextStyle? hintStyle,
    TextInputAction? textInputAction,
    bool? readOnly,
    Function()? onClick,
  }) {
    return PSTextFieldAttributes(
      onChanged: onChanged ?? this.onChanged,
      labelText: labelText ?? this.labelText,
      textEditingController: textEditingController ?? this.textEditingController,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      enabled: enabled ?? this.enabled,
      maxLength: maxLength ?? this.maxLength,
      border: border ?? this.border,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      buildCounter: buildCounter ?? this.buildCounter,
      enableInteractiveSelection: enableInteractiveSelection ?? this.enableInteractiveSelection,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      obscureText: obscureText ?? this.obscureText,
      autocorrect: autocorrect ?? this.autocorrect,
      autoFocus: autoFocus ?? this.autoFocus,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      keyboardType: keyboardType ?? this.keyboardType,
      decoration: decoration ?? this.decoration,
      fontSize: fontSize ?? this.fontSize,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorText: errorText ?? this.errorText,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      focusNode: focusNode ?? this.focusNode,
      cursorColor: cursorColor ?? this.cursorColor,
      hint: hint ?? this.hint,
      hintStyle: hintStyle ?? this.hintStyle,
      textInputAction: textInputAction ?? this.textInputAction,
      readOnly: readOnly ?? this.readOnly,
      onClick: onClick ?? this.onClick,
    );
  }
}

class PSTextField extends StatelessWidget {
  final PSTextFieldAttributes attributes;

  const PSTextField({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  PSTextFieldAttributes _returnLocalizedAttributes(BuildContext context) {
    var newAttributes = attributes;
    if (attributes.decoration != null) {
      newAttributes = attributes.copyWith(
        decoration: attributes.decoration!.copyWith(
          labelText: attributes.decoration!.labelText != null
              ? AppLocalizations.of(context)!.translate(attributes.decoration!.labelText!)
              : (attributes.labelText != null ? AppLocalizations.of(context)!.translate(attributes.labelText!) : null),
          errorText: attributes.decoration!.errorText != null
              ? AppLocalizations.of(context)!.translate(attributes.decoration!.errorText!)
              : (attributes.errorText != null ? AppLocalizations.of(context)!.translate(attributes.errorText!) : null),
          hintText: attributes.decoration!.hintText != null
              ? AppLocalizations.of(context)!.translate(attributes.decoration!.hintText!)
              : (attributes.hint != null ? AppLocalizations.of(context)!.translate(attributes.hint!) : null),
          prefixIcon: attributes.decoration?.prefixIcon,
        ),
      );
    }

    return newAttributes;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: Key('PSTextField'),
      enableInteractiveSelection: attributes.enableInteractiveSelection,
      enableSuggestions: attributes.enableSuggestions,
      autocorrect: attributes.autocorrect,
      obscuringCharacter: attributes.obscuringCharacter,
      obscureText: attributes.obscureText,
      cursorColor: attributes.cursorColor,
      enabled: attributes.enabled ?? true,
      textInputAction: attributes.textInputAction,
      buildCounter: attributes.buildCounter,
      onChanged: attributes.onChanged,
      style: attributes.style,
      keyboardType: attributes.keyboardType,
      onSubmitted: attributes.onSubmitted,
      autofocus: attributes.autoFocus,
      focusNode: attributes.focusNode,
      inputFormatters: [
        ...attributes.inputFormatters ?? <TextInputFormatter>[],
        FilteringTextInputFormatter.deny('"'),
      ],
      controller: attributes.textEditingController,
      maxLength: attributes.maxLength,
      textCapitalization: attributes.textCapitalization ?? TextCapitalization.words,
      readOnly: attributes.readOnly ?? false,
      onTap: attributes.onClick,
      decoration: _returnLocalizedAttributes(context).decoration ??
          InputDecoration(
            prefixIcon: attributes.prefix,
            suffixIcon: attributes.suffix,
            labelText:
                (attributes.labelText != null) ? AppLocalizations.of(context)!.translate(attributes.labelText!) : null,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            alignLabelWithHint: true,
            border: attributes.border,
            hintText: (attributes.hint != null) ? AppLocalizations.of(context)!.translate(attributes.hint!) : null,
            hintStyle: attributes.hintStyle ?? Theme.of(context).inputDecorationTheme.hintStyle,
            hintMaxLines: 1,
            enabledBorder: attributes.enabledBorder,
            focusedBorder: attributes.focusedBorder,
            filled: attributes.backgroundColor != null,
            errorText: attributes.errorText,
            errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
            fillColor: attributes.backgroundColor,
          ),
    );
  }
}
