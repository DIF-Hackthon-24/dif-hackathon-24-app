// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_sheet_header_widget.dart';
import 'package:widget_library/common_widget/card/view_card_detail/model/card_detail_bottom_sheet_model.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _Constants {
  static const paddingTop = 51.0;
  static const paddingBottom = 121.0;
  static const paddingRight = 32.0;
  static const containerColor = Color(0xffF7F7F4);

  static const borderRadius = 10.0;
  static const paddingPinBottom = 6.0;
  static const paddingPinTop = 15.0;
}

class ViewPinBottomSheetWidget extends StatelessWidget {
  final ViewPinAttribute? viewPinDataAttribute;
  Timer? timer;

  ViewPinBottomSheetWidget({
    Key? key,
    this.viewPinDataAttribute,
  }) : super(key: key) {
    timer = Timer(Duration(seconds: 5), () {
      NavigationManager.goBack();
      // 1 time action
      _cancelTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return showActionSheet(
      _getViewPinData(viewPinDataAttribute),
    );
  }

  Widget _getViewPinData(ViewPinAttribute? viewPinContent) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        _cancelTimer();
      },
      /* onWillPop: () async {
        _cancelTimer();
        return true;
      }, */
      child: Column(
        key: Key('ViewPinBottomSheetWidget_getViewPinData_Column'),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BottomSheetHeaderWidget(
              key: Key('ViewPinBottomSheetWidget_getViewPinData_BottomSheetHeaderWidget'),
              cardHeaderData: viewPinContent!.viewPinHeaderText,
              onCloseCallback: _cancelTimer),
          _bottomSheetViewPinContent(viewPinContent.viewPinText!),
        ],
      ),
    );
  }

  Widget _bottomSheetViewPinContent(String cardPinText) {
    return Padding(
      key: Key('ViewPinBottomSheetWidget_bottomSheetViewPinContent_Padding'),
      padding: EdgeInsets.only(
        top: _Constants.paddingTop,
        bottom: _Constants.paddingBottom,
        right: _Constants.paddingRight,
      ),
      child: Container(
        key: Key('ViewPinBottomSheetWidget_bottomSheetViewPinContent_Container'),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_Constants.borderRadius)),
          color: _Constants.containerColor,
        ),
        child: Center(
          key: Key('ViewPinBottomSheetWidget_bottomSheetViewPinContent_Center'),
          child: Container(
            key: Key('ViewPinBottomSheetWidget_bottomSheetViewPinContent_ChildContainer'),
            padding: EdgeInsets.only(
              top: _Constants.paddingPinTop,
              bottom: _Constants.paddingPinBottom,
            ),
            child: PSText(
              text: TextUIDataModel(cardPinText, styleVariant: PSTextStyleVariant.headline1),
              key: Key('ViewPinBottomSheetWidget_bottomSheetViewPinContent_CardPinText'),
            ),
          ),
        ),
      ),
    );
  }

  void _cancelTimer() {
    timer?.cancel();
  }
}
