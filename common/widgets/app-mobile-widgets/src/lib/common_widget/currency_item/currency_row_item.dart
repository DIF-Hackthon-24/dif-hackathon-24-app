import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/currency_item/currency_flag.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/string_extensions.dart';

class CurrencyRowItemState {
  final String name;
  final String symbol;
  final String? flagCountry;
  final bool isSelected;

  CurrencyRowItemState({
    required this.name,
    required this.symbol,
    this.flagCountry,
    this.isSelected = false,
  });
}

/// Displays empty container while flag is loading or if failed to load
class CurrencyRowItemWidget extends StatelessWidget {
  CurrencyRowItemWidget({required this.state, this.onTap});

  final CurrencyRowItemState state;
  final Function(CurrencyRowItemState)? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onTap?.call(state),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CurrencyFlag(state.symbol),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: PSText(
                  text: TextUIDataModel('${state.name}, ${state.symbol}', styleVariant: PSTextStyleVariant.headline2),
                ),
              ),
            ),
            if (state.isSelected) 'widget_library:assets/images/ic_validation_success.svg'.toSvg,
          ],
        ),
      );
}
