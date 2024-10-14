import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonDetailsTopWidgetAttributes {
  final String detailsTitle;

  CommonDetailsTopWidgetAttributes({
    required this.detailsTitle,
  });
}

class CommonDetailsTopWidget extends StatelessWidget {
  const CommonDetailsTopWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonDetailsTopWidgetAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        attributes.detailsTitle,
        styleVariant: PSTextStyleVariant.headline4,
        textAlign: TextAlign.start,
      ),
    );
  }
}
