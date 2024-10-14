import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

import 'page_header_text_under_icon_widget_attributes.dart';

class PSPageHeaderTextUnderIconRowWidget extends StatelessWidget {
  final PSPageHeaderTextUnderIconWidgetAttributes attributes;

  const PSPageHeaderTextUnderIconRowWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('PSPageHeaderTextUnderIconRowWidget_Container'),
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.only(
        top: attributes.headerTopPadding,
        left: attributes.leftMargin,
      ),
      child: Row(
        key: Key('PSPageHeaderTextUnderIconWidget_Row'),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: bodyWidgetsList(context),
      ),
    );
  }

  List<Widget> bodyWidgetsList(BuildContext context) {
    var widgetsList = <Widget>[];

    widgetsList.add(SizedBox(
      key: Key('PSPageHeaderTextUnderIconWidget_bodyWidgetsList_SizedBox'),
      height: attributes.headerTopPadding,
    ));

    for (var attr in attributes.attributesList) {
      if (attr.icon != null) {
        widgetsList.add(
          PSImage(
            PSImageModel(
              iconPath: attr.icon!,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          /* getSvg(
            attr.icon!,
            color: Theme.of(context).iconTheme.color,
          ), */
        );
        widgetsList.add(
          SizedBox(
            key: Key('PSPageHeaderTextUnderIconWidget_bodyWidgetsList_AfterSVGSizedBox'),
            height: attr.padding?.bottom,
          ),
        );
      }
      if (attr.title != null) {
        final text = PSText(
          key: Key('PSPageHeaderTextUnderIconWidget_bodyWidgetsList_TitleText'),
          text: TextUIDataModel(
            attr.title?.text ?? '',
            styleVariant: attr.title?.styleVariant ?? PSTextStyleVariant.headline2,
          ),
        );
        widgetsList.add(text);
      }
    }

    widgetsList.add(
      SizedBox(
        key: Key('PSPageHeaderTextUnderIconWidget_bodyWidgetsList_AfterTextSizedBox'),
        height: attributes.headerBottomPadding,
      ),
    );

    return widgetsList;
  }
}
