import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

@immutable
class BalanceAttributes {
  final String mainAmount;
  final String additionalAmount;
  final String currency;

  BalanceAttributes({
    required this.mainAmount,
    required this.additionalAmount,
    required this.currency,
  });
}

@immutable
class Balance extends StatelessWidget {
  final BalanceAttributes _attributes;

  const Balance({
    Key? key,
    required BalanceAttributes attributes,
  })  : _attributes = attributes,
        super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PSText(
              text: TextUIDataModel(
                _attributes.mainAmount,
                styleVariant: PSTextStyleVariant.headline1,
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.5),
              child: PSText(
                text: TextUIDataModel(
                  '${_attributes.additionalAmount} ${_attributes.currency}',
                  styleVariant: PSTextStyleVariant.bodyText2,
                ),
              ),
            ),
          ],
        ),
      );
}
