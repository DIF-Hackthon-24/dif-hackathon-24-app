import 'package:core/navigation/navigation_manager.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/currency_item/currency_flag.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class CurrencySelectorUIDataModel {
  final String currencySymbol;
  final String? sourceCurrencySymbol;
  final Color? backgroundColor;
  final Function(String)? onCurrencySelected;

  CurrencySelectorUIDataModel(
    this.currencySymbol, {
    this.sourceCurrencySymbol,
    this.onCurrencySelected,
    this.backgroundColor,
  });
}

/// This widget allows just to display or initiate currency selection flow
/// If you want just to display currency pass null for [CurrencySelectorUIDataModel.onCurrencySelected]
/// If you pass a function user will be able to open currency selection screen and you'll get a new currency as a callback.
/// Client responsible himself to redraw CurrencySelectorButton on getting callback
class CurrencySelectorButton extends StatelessWidget {
  final CurrencySelectorUIDataModel uiDataModel;

  const CurrencySelectorButton({
    Key? key,
    required this.uiDataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: uiDataModel.onCurrencySelected == null ? null : _selectCurrency,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            color: uiDataModel.backgroundColor ?? PSTheme().defaultThemeData.textFieldBackgroundColor?.toColor(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CurrencyFlag(uiDataModel.currencySymbol),
                Padding(padding: const EdgeInsets.only(left: 8.0)),
                PSText(
                  text: TextUIDataModel(uiDataModel.currencySymbol),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _selectCurrency() async {
    final newCurrency = await NavigationManager.navigateTo(
      'transfers_common-currency_selector',
      NavigationType.Push,
      arguments: {
        'currency': uiDataModel.currencySymbol,
        'source_currency': uiDataModel.sourceCurrencySymbol,
      },
    ) as String?;

    if (newCurrency != null) {
      uiDataModel.onCurrencySelected?.call(newCurrency);
    }
  }
}
