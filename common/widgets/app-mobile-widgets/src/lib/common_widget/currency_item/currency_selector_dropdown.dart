import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/currency_item/currency_flag.dart';
import 'package:widget_library/dropdown/ps_dropdown.dart';

class CurrencySelectorDropdown extends StatelessWidget {
  CurrencySelectorDropdown({
    required this.title,
    required this.currencySymbol,
    required this.variants,
    this.onCurrencySelected,
    Key? key,
  }) : super(key: key);

  final String title;
  final String currencySymbol;
  final List<String> variants;
  final Function(String)? onCurrencySelected;

  @override
  Widget build(BuildContext context) {
    final isDisabled = variants.length <= 1;

    return PSDropdown(
      title: title,
      defaultVariant: currencySymbol,
      variants: variants,
      prefix: CurrencyFlag(currencySymbol),
      isDisabled: isDisabled,
      suffixIconColor: isDisabled ? Theme.of(context).disabledColor : null,
    );
  }
}
