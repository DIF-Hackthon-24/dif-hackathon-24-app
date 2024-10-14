import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class DefaultCurrencyItem extends StatelessWidget {
  final String label;
  final String defaultIsoCode;
  final String defaultCurrencyName;
  final TextStyle? defaultCurrencyNameStyle;

  const DefaultCurrencyItem({
    Key? key,
    required this.label,
    required this.defaultIsoCode,
    required this.defaultCurrencyName,
    this.defaultCurrencyNameStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('DefaultCurrencyItem_Row'),
      children: [
        CountryPickerUtils.getDefaultFlagImage(
          CountryPickerUtils.getCountryByIsoCode(defaultIsoCode),
        ),
        SizedBox(
          key: Key('DefaultCurrencyItem_SizedBox'),
          width: 18,
        ),
        Column(
          key: Key('DefaultCurrencyItem_Column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              key: Key('DefaultCurrencyItem_LabelText'),
            ),
            Text(
              defaultCurrencyName,
              key: Key('DefaultCurrencyItem_CurrencyNameText'),
              style: defaultCurrencyNameStyle,
            ),
          ],
        ),
      ],
    );
  }
}
