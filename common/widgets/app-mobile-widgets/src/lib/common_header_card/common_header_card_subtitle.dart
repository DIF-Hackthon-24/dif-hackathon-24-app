import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonHeaderCardSubtitleAttributes {
  final String subtitle;
  CommonHeaderCardSubtitleAttributes({
    required this.subtitle,
  });
}

class CommonHeaderCardSubtitle extends StatelessWidget {
  const CommonHeaderCardSubtitle({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonHeaderCardSubtitleAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        attributes.subtitle,
        styleVariant: PSTextStyleVariant.subtitle1,
      ),
    );
  }
}
