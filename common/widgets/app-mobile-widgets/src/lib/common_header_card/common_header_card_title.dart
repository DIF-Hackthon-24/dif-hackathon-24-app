import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonHeaderCardTitleAttributes {
  final String title;
  CommonHeaderCardTitleAttributes({
    required this.title,
  });
}

class CommonHeaderCardTitle extends StatelessWidget {
  const CommonHeaderCardTitle({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonHeaderCardTitleAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        attributes.title,
        styleVariant: PSTextStyleVariant.caption,
      ),
    );
  }
}
