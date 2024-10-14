import 'package:core/utils/extensions/string_extensions.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_library/common_widget/enums/input_form_field_type.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/input_text_view/form_text_field.dart';

class _Constant {
  static const double fieldHeight = 54;
  static const double marginHorizontal = 12;
  static const double tenPixels = 10;
  static const double validIconPadding = 15;
  static const double radius = 4;
}

// ignore: must_be_immutable
class CountryPhoneFormField extends StatefulWidget {
  final Function(String)? onValuePicked;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Function(String)? validator;
  final Color? backgroundColor;
  final String? initialValue;
  final String value;
  final TextStyle? hintStyle;
  final String? hint;
  final String? label;
  final String? errorText;
  final bool isRequired;
  final String? validIconPath;
  Country? selectedCountry;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;
  final InputFormFieldType? type;

  CountryPhoneFormField({
    Key? key,
    this.onValuePicked,
    this.hintText,
    this.onChanged,
    this.focusNode,
    this.validator,
    required this.value,
    this.backgroundColor,
    this.initialValue,
    this.hint,
    this.isRequired = true,
    this.hintStyle,
    this.errorText,
    this.label,
    this.selectedCountry,
    this.onTap,
    this.validIconPath,
    this.formatters,
    this.keyboardType,
    this.type = InputFormFieldType.phoneNumber,
  }) : super(key: key);

  @override
  _CountryPhoneFormFieldState createState() => _CountryPhoneFormFieldState();
}

class _CountryPhoneFormFieldState extends State<CountryPhoneFormField> {
  final countryInstanceList = List<Country>.from(countryList);

  @override
  void initState() {
    super.initState();
    widget.selectedCountry = countryList.firstWhere((country) => country.isoCode == widget.value.toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final psTheme = PSTheme();
    final country = widget.selectedCountry ?? CountryPickerUtils.getCountryByIsoCode(widget.value);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: Key('CountryPhoneFormField_Row'),
      children: <Widget>[
        if (widget.type == InputFormFieldType.phoneNumber)
          Container(
            height: _Constant.fieldHeight,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? psTheme.defaultThemeData.textFieldBackgroundColor.toColor(),
              borderRadius: BorderRadius.all(Radius.circular(_Constant.radius)),
            ),
            padding: EdgeInsets.all(_Constant.tenPixels),
            child: InkWell(
              onTap: widget.onTap,
              child: Center(
                child: _buildDropdownItem(theme.textTheme.bodyLarge, country),
              ),
            ),
          ),
        if (widget.type == InputFormFieldType.internationalPhoneNumber)
          Container(
            height: _Constant.fieldHeight,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? psTheme.defaultThemeData.textFieldBackgroundColor.toColor(),
              borderRadius: BorderRadius.all(Radius.circular(_Constant.radius)),
            ),
            padding: EdgeInsets.only(
              left: _Constant.tenPixels,
              top: _Constant.tenPixels,
              bottom: _Constant.tenPixels,
            ),
            child: CountryPickerDropdown(
              initialValue: widget.value,
              itemBuilder: (country) => _buildDropdownItem(theme.textTheme.bodyLarge, country),
              onValuePicked: (c) {
                widget.onValuePicked?.call(c.isoCode);
              },
              icon: null,
            ),
          ),
        Container(width: _Constant.marginHorizontal),
        Expanded(
          key: Key('secondCountryPhoneFormField_Expanded'),
          child: FormTextField(
            key: Key('CountryPhoneFormField_TextFormField'),
            formatters: widget.formatters,
            hintStyle: widget.hintStyle,
            validator: widget.validator,
            errorText: widget.errorText,
            onChanged: widget.onChanged,
            initialValue: widget.initialValue,
            isRequired: widget.isRequired,
            textInputType: widget.keyboardType ?? TextInputType.phone,
            labelText: widget.label ?? widget.hint,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffix: widget.validIconPath != null
                ? Padding(
                    padding: EdgeInsets.all(_Constant.validIconPadding),
                    child: PSImage(
                      PSImageModel(
                        iconPath: widget.validIconPath!,
                        height: _Constant.tenPixels,
                        width: _Constant.tenPixels,
                        color: psTheme.themeData.colorPalette?.octonary?.toColor(),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownItem(TextStyle? style, Country country) => Row(
        key: Key('CountryPhoneFormField_buildDropdownItemRow_${country.isoCode}'),
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text(
            '+${country.phoneCode}',
            key: Key('CountryPhoneFormField_buildDropdownItemText_${country.isoCode}'),
            style: style,
          ),
        ],
      );
}
