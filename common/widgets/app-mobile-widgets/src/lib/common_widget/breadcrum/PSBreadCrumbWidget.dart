import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/breadcrum/PSBreadCrumbWidgetAttribute.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _Constants {
  static final circularRadius = 10.0;
  static final paddingHorizontal = 16.0;
  static final paddingVertical = 8.0;
}

class PSBreadCrumbWidget extends StatelessWidget {
  final PSBreadCrumbWidgetAttribute attributes;
  const PSBreadCrumbWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: _Constants.paddingHorizontal, vertical: _Constants.paddingVertical),
      decoration: BoxDecoration(
        color: attributes.backgroundColor,
        borderRadius: BorderRadius.circular(_Constants.circularRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PSText(
            text: TextUIDataModel(attributes.label, styleVariant: PSTextStyleVariant.headline4),
            key: Key('ChipWidget_progressCompletedWidget_CompletedLabelText'),
          ),
          SizedBox(width: _Constants.paddingHorizontal),
          GestureDetector(
            onTap: attributes.onCrossTap,
            child: PSImage(
              PSImageModel(
                iconPath: 'app_mobile_invoice:assets/images/ic_close.svg',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
