import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

import 'chip_widget_attributes.dart';

class ChipWidget extends StatelessWidget {
  final ChipWidgetAttributes attributes;

  const ChipWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
      decoration: BoxDecoration(
        color: attributes.backgroundColor,
        borderRadius: BorderRadius.circular(38),
      ),
      child: PSText(
        text: TextUIDataModel(attributes.label, styleVariant: PSTextStyleVariant.bodyText2),
        key: Key('ChipWidget_progressCompletedWidget_CompletedLabelText'),
      ),
    );
  }
}
