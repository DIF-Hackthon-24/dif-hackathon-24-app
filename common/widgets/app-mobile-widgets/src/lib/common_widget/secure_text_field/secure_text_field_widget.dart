import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/secure_text_field/secure_text_field_attributes.dart';
import 'package:widget_library/string_extensions.dart';

///
/// Note This has been styled based on its usage as the password field for login
///
class SecureTextFieldWidget extends StatefulWidget {
  final SecureTextFieldAttributes attributes;

  const SecureTextFieldWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  _CreatePasswordTextFieldWidgetState createState() => _CreatePasswordTextFieldWidgetState();
}

class _CreatePasswordTextFieldWidgetState extends State<SecureTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('SecureTextFieldWidget_Column'),
      children: [
        TextField(
          key: Key('SecureTextFieldWidget_TextField'),
          // cursorColor: theme.colorStyles.staticTextColors.secondary.color,
          onChanged: (value) {
            widget.attributes.onTextChanged(value);
          },
          // style: theme.textStyles.textInputs.primary,
          textCapitalization: TextCapitalization.none,
          enableSuggestions: false,
          autocorrect: false,
          obscureText: widget.attributes.isSecure,
          obscuringCharacter: widget.attributes.obscuringCharacter,
          decoration: InputDecoration(
            suffixIcon: getSuffixIcon(),
            labelText: widget.attributes.header.text,
            alignLabelWithHint: true,
            // focusColor: theme.colorStyles.textInputColors.hint.color,
            floatingLabelBehavior:
                widget.attributes.hideFloatingLabel ? FloatingLabelBehavior.never : FloatingLabelBehavior.auto,
            focusedBorder: UnderlineInputBorder(
                // borderSide: BorderSide(color: theme.colorStyles.textInputColors.hint.color),
                ),
          ),
        ),
      ],
    );
  }

  Widget? getSuffixIcon() {
    Widget? widgetResult;
    if (widget.attributes.showHideIconPath != null) {
      widgetResult = InkWell(
        key: Key('SecureTextFieldWidget_getSuffixIcon_InkWell'),
        onTap: () {
          widget.attributes.onSuffixIconTap?.call();
        },
        child: SizedBox(
          key: Key('SecureTextFieldWidget_getSuffixIcon_SizedBox'),
          height: 40,
          width: 40,
          child: widget.attributes.showHideIconPath?.toSvg,
        ),
      );
    }
    return widgetResult;
  }
}
