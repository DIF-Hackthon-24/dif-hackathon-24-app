import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/model/card_detail_bottom_sheet_model.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/page_header_text_under_icon/page_header_text_under_icon_widget.dart';

class _Constants {
  static const contentPadding = EdgeInsets.only(left: 0.0, right: 0.0);
  static const visualDensity =
      VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity);
  static const topPadding = 30.0;
  static const leftPadding = 32.0;
}

class BottomSheetHeaderWidget extends StatelessWidget {
  final CardRowHeaderModel? cardHeaderData;
  final VoidCallback? onCloseCallback;
  const BottomSheetHeaderWidget({Key? key, this.cardHeaderData, this.onCloseCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _bottomHeaderContent(cardHeaderData, context);
  }

  Widget _bottomHeaderContent(
    CardRowHeaderModel? headerData,
    BuildContext context,
  ) {
    return Container(
      key: Key('_bottomHeaderContent_Container'),
      padding: EdgeInsets.only(
        bottom: _Constants.topPadding,
      ),
      child: ListTile(
        key: Key('_bottomHeaderContent_ListTile'),
        contentPadding: _Constants.contentPadding,
        visualDensity: _Constants.visualDensity,
        leading: headerData?.secondIconPath != null
            ? IconButton(
                //icon: getSvg(headerData!.secondIconPath!),
                onPressed: headerData?.iconAction,
                icon: PSImage(
                  PSImageModel(iconPath: headerData!.secondIconPath!),
                ),
              )
            : null,
        title: headerData!.labelText != null
            ? PSText(text: TextUIDataModel(headerData.labelText!, styleVariant: PSTextStyleVariant.headline2))
            : PSPageHeaderTextUnderIconWidget(attributes: headerData.labelTextAttributes!),
        trailing: IconButton(
          key: Key('_bottomHeaderContent_IconButton'),
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(right: _Constants.leftPadding),
          onPressed: () {
            onCloseCallback?.call();
            Navigator.pop(context);
          },
          //icon: getSvg(headerData.iconPath!),
          icon: PSImage(
            PSImageModel(
              iconPath: headerData.iconPath!
            ),
          ),
        ),
      ),
    );
  }
}
