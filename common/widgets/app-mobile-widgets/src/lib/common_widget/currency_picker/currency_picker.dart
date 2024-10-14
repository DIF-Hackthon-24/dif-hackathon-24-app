import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class CurrencyPicker extends StatelessWidget {
  final String value;
  final TextStyle? valueTextStyle;
  final Function(String)? onValuePicked;

  const CurrencyPicker({
    Key? key,
    required this.value,
    this.valueTextStyle,
    this.onValuePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('CurrencyPicker_Container'),
      // color: theme.colorStyles.textInputColors.background.color,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        key: Key('CurrencyPicker_Row'),
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            key: Key('CurrencyPicker_Expanded'),
            child: Container(
              key: Key('CurrencyPicker_ChildContainer'),
              child: Padding(
                key: Key('CurrencyPicker_Padding'),
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  value,
                  key: Key('CurrencyPicker_ValueText'),
                  style: valueTextStyle,
                ),
              ),
            ),
          ),
          CountryPickerDropdown(
            initialValue: value,
            itemBuilder: _buildDropdownItem,
            onValuePicked: (c) {
              onValuePicked?.call(c.iso3Code);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(Country country) => Container(
        key: Key('CurrencyPicker_buildDropdownItemContainer'),
        child: CountryPickerUtils.getDefaultFlagImage(
          CountryPickerUtils.getCountryByIsoCode(country.isoCode),
        ),
      );
}
