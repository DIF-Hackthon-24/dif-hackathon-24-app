import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

/// Show the flag for a particular currency.
class CurrencyFlag extends StatelessWidget {
  CurrencyFlag(
    String symbol, {
    this.height = 20,
    this.width = 30,
    this.withBorder = false,
    this.borderColor,
  }) {
    assert(symbol.length == 3, 'CurrencyFlag symbol is not valid: "$symbol"');
    this.symbol = symbol.toLowerCase();
  }

  late final String symbol;
  final double height;
  final double width;
  final bool withBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    Widget flag;
    switch (symbol) {
      case 'eur':
        // Exception for Euro as this flag is not in the country pickers library
        flag = _getImage(
          'assets/images/ic_flag_eu.png',
          'widget_library',
        );
        break;
      default:
        flag = _loadCountryFlag();
    }

    if (!withBorder) {
      return flag;
    }

    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: borderColor ?? Theme.of(context).primaryColor.withOpacity(0.03)),
      ),
      child: flag,
    );
  }

  Widget _loadCountryFlag() {
    final countryCode = _symbolToCountryCodeExceptions[symbol] ?? symbol.substring(0, 2);
    final country = CountryPickerUtils.getCountryByIsoCode(countryCode);
    return _getImage(
      CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
      'country_pickers',
    );
  }

  Widget _getImage(String name, String package) {
    try {
      return Image.asset(
        name,
        height: height,
        width: width,
        fit: BoxFit.cover,
        package: package,
      );
    } catch (error) {
      return SizedBox(width: width, height: height);
    }
  }

  // First 2 characters of currency codes generally map to the 2 digit ISO Code.
  // Exceptions are here
  final _symbolToCountryCodeExceptions = {
    'xof': 'tg',
  };
}
