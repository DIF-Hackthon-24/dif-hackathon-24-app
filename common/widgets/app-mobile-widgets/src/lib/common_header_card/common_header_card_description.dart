import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonHeaderCardDescriptionAttributes {
  final String description;
  CommonHeaderCardDescriptionAttributes({
    required this.description,
  });
}

class CommonHeaderCardDescription extends StatelessWidget {
  const CommonHeaderCardDescription({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonHeaderCardDescriptionAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        attributes.description,
      ),
    );
  }
}
