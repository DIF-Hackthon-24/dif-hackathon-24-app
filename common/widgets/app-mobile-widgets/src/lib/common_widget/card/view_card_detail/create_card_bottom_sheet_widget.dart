import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_sheet_header_widget.dart';
import 'package:widget_library/common_widget/card/view_card_detail/model/create_card_bottom_sheet_widget_attributes.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _Constants {
  static const paddingTop = 26.0;
  static const paddingBottom = 20.0;
  static const paddingLeft = 20.0;
  static const paddingRight = 20.0;
  static const paddingItemBetween = 16.0;

  static const cardSize = Size(260, 320);

  static const radius = 10.0;
  static const radiusComingSoon = 20.0;
  static const paddingComingSoon = 7.0;
  static const opacityComingSoon = 0.3;
  static const marginTitle = 34.0;
  static const marginDescription = 12.0;
  static const marginAction = 30.0;
}

class CreateCardBottomSheetWidget extends StatelessWidget {
  final CreateCardBottomSheetWidgetAttributes attributes;

  const CreateCardBottomSheetWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showActionSheet(
      _getCreateCardData(attributes),
    );
  }

  Widget _getCreateCardData(CreateCardBottomSheetWidgetAttributes? createCardAttributes) {
    var _addCardData = <Widget>[
      BottomSheetHeaderWidget(
        key: Key('CreateCardBottomSheetWidget_BottomSheetHeaderWidget'),
        cardHeaderData: createCardAttributes!.createCardHeaderText,
      ),
      SizedBox(
        height: attributes.borderPadding.height,
        child: ListView(
          key: Key('CreateCardBottomSheetWidget_tabBarView_ListView'),
          padding: EdgeInsets.only(right: _Constants.paddingRight),
          scrollDirection: Axis.horizontal,
          children: createCardAttributes.createCardData!.map((e) {
            return _bottomSheetCreateCardContent(e);
          }).toList(),
        ),
      ),
    ];

    return Column(
      key: Key('CreateCardBottomSheetWidget_getCreateCardDataColumn'),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _addCardData,
    );
  }

  Widget _bottomSheetCreateCardContent(CreateCardRowModel cardRowData) {
    String cardtype = 'VIRTUAL CARD';
    return Builder(
      builder: (context) => Padding(
        key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_Padding'),
        padding: EdgeInsets.only(right: _Constants.paddingItemBetween),
        child: GestureDetector(
          key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_GestureDetector'),
          onTap: () {
            // Close bottom sheet before navigating to another screen
            Navigator.pop(context);
            cardRowData.action?.call();
          },
          child: Container(
            key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_Container'),
            padding: EdgeInsets.only(
              top: _Constants.paddingTop,
              left: _Constants.paddingLeft,
              bottom: _Constants.paddingBottom,
              right: _Constants.paddingRight,
            ),
            width: _Constants.cardSize.width,
            height: _Constants.cardSize.height,
            decoration: BoxDecoration(
              color: cardRowData.background,
              borderRadius: BorderRadius.circular(_Constants.radius),
              boxShadow: [
                BoxShadow(
                  // color: attributes.shadowColor.color,
                  spreadRadius: 0,
                  //  blurRadius: 30,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _GrayedOut(
                      grayedOut: cardRowData.cardComingSoon,
                      //child: getSvg(cardRowData.iconPath!),
                      child: PSImage(
                        PSImageModel(iconPath: cardRowData.iconPath!),
                      ),
                    ),
                    Spacer(),
                    if (cardRowData.cardComingSoon)
                      _ComingSoon(color: cardRowData.comingSoonBackground, title: cardRowData.comingSoonTitle!)
                  ],
                ),
                _GrayedOut(
                  grayedOut: cardRowData.cardComingSoon,
                  child: Padding(
                    key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_PaddingTitle'),
                    padding: EdgeInsets.only(
                      top: _Constants.marginTitle,
                      bottom: _Constants.marginDescription,
                    ),
                    child: PSText(
                      text: TextUIDataModel(cardRowData.labelTitle!,
                          styleVariant: (cardRowData.labelTitle == cardtype)
                              ? PSTextStyleVariant.headline1
                              : PSTextStyleVariant.headline3),
                      key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_LabelTitle'),
                    ),
                  ),
                ),
                _GrayedOut(
                  grayedOut: cardRowData.cardComingSoon,
                  child: PSText(
                    text: TextUIDataModel(cardRowData.labelDescription!,
                        styleVariant: (cardRowData.labelTitle == cardtype)
                            ? PSTextStyleVariant.headline4
                            : PSTextStyleVariant.headline5),
                    key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_LabelDescription'),
                  ),
                ),
                SizedBox(
                  key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_LabelTitle'),
                  height: _Constants.marginAction,
                ),
                _GrayedOut(
                  grayedOut: cardRowData.cardComingSoon,
                  child: ListTile(
                    key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_ListTileAction'),
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    visualDensity: VisualDensity(
                      horizontal: 0,
                      vertical: -4,
                    ),
                    dense: true,
                    title: PSText(
                      text: TextUIDataModel(cardRowData.labelAction!,
                          styleVariant: (cardRowData.labelTitle == cardtype)
                              ? PSTextStyleVariant.headline6
                              : PSTextStyleVariant.headline5),
                      key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_LabelAction'),
                    ),
                    trailing: IconButton(
                      key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_IconButton'),
                      /* icon: getSvg(
                        cardRowData.secondIconPath!,
                        color: (cardRowData.labelTitle == cardtype)
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).primaryColor,
                      ), */
                      onPressed: null,
                      icon: PSImage(
                        PSImageModel(
                          iconPath: cardRowData.secondIconPath!,
                          color: (cardRowData.labelTitle == cardtype)
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
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

class _GrayedOut extends StatelessWidget {
  final Widget child;
  final bool grayedOut;
  const _GrayedOut({Key? key, required this.child, required this.grayedOut}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return grayedOut ? Opacity(opacity: _Constants.opacityComingSoon, child: child) : child;
  }
}

class _ComingSoon extends StatelessWidget {
  final Color? color;
  final String title;
  const _ComingSoon({Key? key, this.color, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_Constants.paddingComingSoon),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(_Constants.radiusComingSoon),
      ),
      child: PSText(
        text: TextUIDataModel(title, styleVariant: PSTextStyleVariant.bodyText2),
        key: Key('CreateCardBottomSheetWidget_BottomSheetCreateCardContent_coming_soon'),
      ),
    );
  }
}
