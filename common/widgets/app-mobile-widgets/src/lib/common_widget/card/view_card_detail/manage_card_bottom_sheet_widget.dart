import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_sheet_header_widget.dart';
import 'package:widget_library/common_widget/card/view_card_detail/model/card_detail_bottom_sheet_model.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class _Constants {
  static const paddingTop = 17.0;
  static const paddingBottom = 17.0;
  static const paddingLeft = 17.0;
  static const paddingRight = 17.0;
  static const paddingItemBetween = 12.0;
  static const cardSize = Size(140, 120);
  static const radius = 10.0;
}

class ManageCardBottomSheetWidget extends StatelessWidget {
  final ManageCardAttributes manageCardAttributes;

  const ManageCardBottomSheetWidget({
    Key? key,
    required this.manageCardAttributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showActionSheet(
      _getManageCardData(manageCardAttributes),
    );
  }

  Widget _getManageCardData(ManageCardAttributes manageCardAttributes) {
    final _addCardData = <Widget>[
      BottomSheetHeaderWidget(
        key: Key('ManageCardBottomSheetWidget_BottomSheetHeaderWidget'),
        cardHeaderData: manageCardAttributes.manageCardHeaderText,
      ),
      Container(
        height: _Constants.cardSize.height,
        child: ListView(
          shrinkWrap: true,
          key: Key('ManageCardBottomSheetWidget_ListView'),
          padding: EdgeInsets.only(right: _Constants.paddingRight),
          scrollDirection: Axis.horizontal,
          children: manageCardAttributes.manageCardData!.map((e) {
            return _buildManageCardItem(e);
          }).toList(),
        ),
      ),
    ];

    return Column(
      key: Key('ManageCardBottomSheetWidget_getManageCardDataColumn'),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _addCardData,
    );
  }

  // ignore: long-method
  Widget _buildManageCardItem(CardRowHeaderModel cardModel) {
    return Builder(
      builder: (context) => Padding(
        key: Key('ManageCardBottomSheetWidget_BottomSheetManageCardContent_Padding'),
        padding: EdgeInsets.only(right: _Constants.paddingItemBetween),
        child: GestureDetector(
          key: Key('ManageCardBottomSheetWidget_BottomSheetManageCardContent_GestureDetector'),
          onTap: () {
            // Close bottom sheet before navigating to another screen
            Navigator.pop(context);
            cardModel.iconAction?.call();
          },
          child: Container(
            key: Key('ManageCardBottomSheetWidget_BottomSheetManageCardContent_Container'),
            padding: EdgeInsets.only(
              top: _Constants.paddingTop,
              left: _Constants.paddingLeft,
              bottom: _Constants.paddingBottom,
              right: _Constants.paddingRight,
            ),
            width: _Constants.cardSize.width,
            decoration: BoxDecoration(
              color: cardModel.background ?? PSTheme().themeData.colorPalette!.panelColorTertiary!.toColor(),
              borderRadius: BorderRadius.circular(_Constants.radius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* getSvg(
                  cardModel.iconPath!,
                  color: PSTheme().themeData.colorPalette!.secondary!.toColor(),
                ), */
                PSImage(
                  PSImageModel(
                    iconPath: cardModel.iconPath!,
                    color:
                        PSTheme().themeData.colorPalette!.secondary!.toColor(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: [
                      PSText(
                        key: Key('ManageCardBottomSheetWidget_BottomSheetManageCardContent_LabelTitle'),
                        text: TextUIDataModel(
                          cardModel.labelText ?? '',
                          styleVariant: PSTextStyleVariant.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
