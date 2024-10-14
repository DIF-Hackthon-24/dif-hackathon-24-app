import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonDetailsTitleAttributes {
  final String commonTitle;

  CommonDetailsTitleAttributes({
    required this.commonTitle,
  });
}

class CommonDetailsTitle extends StatelessWidget {
  const CommonDetailsTitle({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonDetailsTitleAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        attributes.commonTitle,
        styleVariant: PSTextStyleVariant.headline6,
        textAlign: TextAlign.start,
      ),
    );
  }
}
