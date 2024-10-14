import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class PSCountryDropdownPicker extends StatelessWidget {
  final ValueChanged<Country> onValuePicked;
  final bool showPhoneCode;

  const PSCountryDropdownPicker({
    Key? key,
    required this.onValuePicked,
    this.showPhoneCode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountryPickerDropdown(
      initialValue: 'AE',
      itemBuilder: _buildDropdownItem,
      onValuePicked: onValuePicked,
    );
  }

  Widget _buildDropdownItem(Country country) => Container(
    key: Key('PSCountryDropdownPicker_buildDropdownItem_Container'),
        child: Row(
          key: Key('PSCountryDropdownPicker_buildDropdownItem_Row'),
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              key: Key('PSCountryDropdownPicker_buildDropdownItem_SizedBox'),
              width: 8.0,
            ),
            if (showPhoneCode) Text('+${country.phoneCode}', key: Key('PSCountryDropdownPicker_buildDropdownItem_Text'),),
          ],
        ),
      );
}
