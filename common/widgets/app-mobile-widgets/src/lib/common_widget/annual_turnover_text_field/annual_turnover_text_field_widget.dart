import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_library/common_widget/input_field/ps_text_field.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class AnnualTurnoverTextFieldWidget extends StatefulWidget {
  final AnnualTurnoverTextFieldAttributes attributes;

  const AnnualTurnoverTextFieldWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  _AnnualTurnoverTextFieldWidgetState createState() => _AnnualTurnoverTextFieldWidgetState();
}

class _AnnualTurnoverTextFieldWidgetState extends State<AnnualTurnoverTextFieldWidget> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _onFocusChange,
      child: PSTextField(
        key: Key('AnnualTurnover_PSTextField'),
        attributes: PSTextFieldAttributes(
            onChanged: (v) {
              widget.attributes.onAnnualTurnoverChanged?.call(v.replaceAll(',', ''));
            },
            textCapitalization: TextCapitalization.none,
            textInputAction: widget.attributes.textInputAction,
            labelText: widget.attributes.header.text,
            keyboardType: TextInputType.number,
            inputFormatters: [
              _AnnualTurnoverFormatter(),
              FilteringTextInputFormatter.deny(' '),
            ],
            onSubmitted: (v) {
              widget.attributes.onEditingCompleted?.call(v.replaceAll(',', ''));
            },
            style: Theme.of(context)
                .inputDecorationTheme
                .labelStyle!
                .copyWith(color: Theme.of(context).textTheme.titleLarge!.color),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PSTheme().themeData.colorPalette!.nonary!.toColor())),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PSTheme().themeData.colorPalette!.nonary!.toColor())),
              labelText: widget.attributes.header.text,
              alignLabelWithHint: true,
              suffix: Text(
                'AED',
                key: Key('PsCupertinoPicker_ValueText'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
              errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
            )),
      ),
    );
  }

  void _onFocusChange(bool focus) {
    setState(() => hasFocus = focus);
  }
}

class AnnualTurnoverTextFieldAttributes {
  final TextUIDataModel header;
  final TextUIDataModel hint;
  final TextInputAction? textInputAction;
  final Function(String email)? onAnnualTurnoverChanged;
  final Function(String email)? onEditingCompleted;
  final FocusNode? nextFocusNode;
  final String errorText;

  const AnnualTurnoverTextFieldAttributes({
    required this.header,
    required this.hint,
    this.textInputAction,
    this.onAnnualTurnoverChanged,
    this.onEditingCompleted,
    this.nextFocusNode,
    this.errorText = '',
  });

  AnnualTurnoverTextFieldAttributes copyWith({
    TextUIDataModel? header,
    TextUIDataModel? hint,
    TextInputAction? textInputAction,
    Function(String turnover)? onAnnualTurnoverChanged,
    Function(String turnover)? onEditingCompleted,
    FocusNode? nextFocusNode,
    String errorText = '',
  }) =>
      AnnualTurnoverTextFieldAttributes(
        header: header ?? this.header,
        hint: hint ?? this.hint,
        textInputAction: textInputAction,
        onAnnualTurnoverChanged: onAnnualTurnoverChanged ?? this.onAnnualTurnoverChanged,
        onEditingCompleted: onEditingCompleted ?? this.onEditingCompleted,
        nextFocusNode: nextFocusNode,
        errorText: errorText.isNotEmpty ? errorText : this.errorText,
      );
}

class _AnnualTurnoverFormatter extends TextInputFormatter {
  static final _validationMask = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final toFormat = newValue.text.replaceAll(',', '');
    var newText = toFormat.replaceAllMapped(
      _validationMask,
      (Match m) => '${m[1]},',
    );

    return newValue.copyWith(
      selection: TextSelection.fromPosition(TextPosition(offset: newText.length)),
      text: newText,
    );
  }
}
