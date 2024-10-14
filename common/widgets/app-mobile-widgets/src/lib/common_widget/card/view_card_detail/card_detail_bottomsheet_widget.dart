import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_sheet_header_widget.dart';
import 'package:widget_library/common_widget/card/view_card_detail/model/card_detail_bottom_sheet_model.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _Constants {
  static const sizeBoxHeight = 12.0;
  static const paddingInternal = 4.0;
  static const paddingRight = 32.0;
  static const paddingLeft = 20.0;
  static const containerColor = Color(0xffF7F7F4);

  static const borderRadius = 10.0;
  static const containerHeight = 65.0;
}

class CardDetailBottomSheetWidget extends StatelessWidget {
  final CardDetailsAttribute? cardDetailsAttribute;

  const CardDetailBottomSheetWidget({Key? key, this.cardDetailsAttribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showActionSheet(
      _getCardDetailsData(cardDetailsAttribute),
    );
  }

  Widget _getCardDetailsData(CardDetailsAttribute? cardDetailsContent) {
    int index = 0;
    final _addCardDetailData = <Widget>[
      BottomSheetHeaderWidget(
        key: Key('CardDetailBottomSheetWidget_getCardDetailsData_BottomSheetHeaderWidget'),
        cardHeaderData: cardDetailsContent!.cardHeaderText,
      ),
      ...cardDetailsContent.cardMapData?.map(
            (e) {
              index++;
              return _bottomSheetCardDetailsContent(e, index);
            },
          ).toList() ??
          [],
      SizedBox(
        height: _Constants.sizeBoxHeight,
      ),
    ];

    return Column(
      key: Key('CardDetailBottomSheetWidget_getCardDetailsData_BottomSheetHeaderWidgetColumn'),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _addCardDetailData,
    );
  }

  Widget _bottomSheetCardDetailsContent(
    CardDetailTitleAndSubTitleModel? cardDetailRowData,
    int index,
  ) {
    return Column(
      key: Key('CardDetailBottomSheetWidget_bottomSheetCardDetailsContent_Column_{$index}'),
      children: [
        Padding(
          key: Key('CardDetailBottomSheetWidget_bottomSheetCardDetailsContent_Padding'),
          padding: const EdgeInsets.only(right: _Constants.paddingRight),
          child: Container(
            key: Key('CardDetailBottomSheetWidget_bottomSheetCardDetailsContent_Container'),
            padding: EdgeInsets.only(left: _Constants.paddingLeft),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(_Constants.borderRadius)),
              color: _Constants.containerColor,
            ),
            child: _setCardDetailsData(cardDetailRowData),
          ),
        ),
        SizedBox(
          key: Key('CardDetailBottomSheetWidget_bottomSheetCardDetailsContent_SizedBox'),
          height: _Constants.sizeBoxHeight,
        ),
      ],
    );
  }
}

Widget _setCardDetailsData(
  CardDetailTitleAndSubTitleModel? cardDetailRowData,
) {
  return Container(
    key: Key('CardDetailBottomSheetWidget_setCardDetailData_Container'),
    height: _Constants.containerHeight,
    child: Row(
      children: [
        Expanded(
          child: Column(
            key: Key('CardDetailBottomSheetWidget_setCardDetailData_Column'),
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PSText(
                text: TextUIDataModel(cardDetailRowData!.labelText!, styleVariant: PSTextStyleVariant.headline6),
                key: Key('CardDetailBottomSheetWidget_setCardDetailData_LabelText'),
              ),
              Container(
                key: Key('CardDetailBottomSheetWidget_setCardDetailData_Container'),
                padding: EdgeInsets.only(top: _Constants.paddingInternal),
                child: PSText(
                  text: TextUIDataModel(cardDetailRowData.titleText!, styleVariant: PSTextStyleVariant.headline5),
                  key: Key('CardDetailBottomSheetWidget_setCardDetailData_TitleText'),
                ),
              ),
            ],
          ),
        ),
        if (cardDetailRowData.linkText != null) cardDetailRowData.linkText!
      ],
    ),
  );
}
