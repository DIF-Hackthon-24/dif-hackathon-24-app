import 'package:flutter/cupertino.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonDetailsBottomTextWidgetsAttributes {
  final String detailsTextBottomValue;

  CommonDetailsBottomTextWidgetsAttributes({
    required this.detailsTextBottomValue,
  });
}

class CommonDetailsBottomTextWidgets extends StatelessWidget {
  const CommonDetailsBottomTextWidgets({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonDetailsBottomTextWidgetsAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        attributes.detailsTextBottomValue,
        styleVariant: PSTextStyleVariant.subtitle1,
        textAlign: TextAlign.start,
      ),
    );
  }
}
