import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/custom_buttons.dart';
import 'package:widget_library/underline_widget.dart';

import 'common_widget/theme/ps_theme.dart';
import 'page_header_text_under_icon/page_header_text_under_icon_widget.dart';
import 'page_header_text_under_icon/page_header_text_under_icon_widget_attributes.dart';

enum CommonIconBottomSheet {
  warningIcon,
  thumbIcon,
}

extension CommonIconBottomSheetExt on CommonIconBottomSheet {
  String get getIcon {
    switch (this) {
      case CommonIconBottomSheet.warningIcon:
        return 'assets/icons/warning_bottom_sheet_icon.svg';
      case CommonIconBottomSheet.thumbIcon:
        return 'dashboard:assets/icons/thumb_icon.svg';
    }
  }
}

class _Constants {
  static const defaultTheme = 'common_bottom_sheet';
  static const minHeightBottomSheet = 200.0;
  static const iconSize = 100.0;
  static const String defaultIconPath =
      'widget_library:assets/images/exemption_service_request_confirm.svg';
  static const double zeroPixels = 0.0;
  static const double twenty = 20;
  static const double sixteen = 16;
  static const double thirty = 30;
}

class CommonBottomSheetAttributes {
  CommonBottomSheetAttributes({
    required this.isRTL,
    required this.title,
    required this.description,
    required this.primaryCTAText,
    required this.secondaryCTAText,
    this.theme,
    this.infoIcon,
    this.commonIcon,
    this.onBack,
    this.onPrimaryCTAPressed,
    this.onSecondaryCTAPressed,
    this.isSecondaryCTAShow = true,
    this.isPrimaryCTAShow = true,
    this.secondaryShowProgressEnabled = false,
    this.primartCTADisableOnSecondaryCTAPressed = false,
    this.highlightedDescriptionTexts,
  });

  final bool isRTL;
  final String title;
  final String description;
  final List<String>? highlightedDescriptionTexts;
  final String primaryCTAText;
  final String secondaryCTAText;
  final String? theme;
  final String? infoIcon;
  final CommonIconBottomSheet? commonIcon;
  final bool isSecondaryCTAShow;
  final bool isPrimaryCTAShow;
  final bool secondaryShowProgressEnabled;
  final bool primartCTADisableOnSecondaryCTAPressed;
  final VoidCallback? onBack;
  final VoidCallback? onPrimaryCTAPressed;
  final VoidCallback? onSecondaryCTAPressed;
}

class CommonBottomSheetView extends StatefulWidget {
  const CommonBottomSheetView({
    required this.attributes,
    Key? key,
  }) : super(key: key);

  final CommonBottomSheetAttributes attributes;

  @override
  State<CommonBottomSheetView> createState() => _CommonBottomSheetViewState();
}

class _CommonBottomSheetViewState extends State<CommonBottomSheetView> {
  bool isSecondaryCTAPressed = false;

  String get getCenterIcon {
    if (widget.attributes.commonIcon != null) {
      return widget.attributes.commonIcon!.getIcon;
    }
    if ((widget.attributes.infoIcon ?? '').isNotEmpty) {
      return widget.attributes.infoIcon!;
    }
    return _Constants.defaultIconPath;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: PSTheme()
          .themeFor(widget.attributes.theme ?? _Constants.defaultTheme),
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints:
                  BoxConstraints(minHeight: _Constants.minHeightBottomSheet),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_Constants.twenty),
                  topRight: Radius.circular(_Constants.twenty),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(
                      _Constants.zeroPixels,
                      -(_Constants.iconSize / 2),
                      _Constants.zeroPixels,
                    ),
                    child: PSImage(
                      PSImageModel(
                        iconPath: getCenterIcon,
                        height: _Constants.iconSize,
                        width: _Constants.iconSize,
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(
                      _Constants.zeroPixels,
                      -(_Constants.iconSize / 4),
                      _Constants.zeroPixels,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: _Constants.twenty,
                    ),
                    child: Column(
                      children: [
                        PSText(
                          text: TextUIDataModel(
                            widget.attributes.title,
                            textAlign: TextAlign.center,
                            styleVariant: PSTextStyleVariant.headline1,
                          ),
                        ),
                        const SizedBox(height: _Constants.sixteen),
                        SizedBox(
                          child: PSPageHeaderTextUnderIconWidget(
                            attributes:
                                PSPageHeaderTextUnderIconWidgetAttributes(
                              headerTopPadding: 0,
                              headerBottomPadding: 0,
                              leftMargin: 0,
                              rightMargin:  widget.attributes.isRTL ? _Constants.thirty : 0,
                              attributesList: [
                                PSPageHeaderTextUnderIconWidgetElementAttributes(
                                  title: TextUIDataModel(
                                    widget.attributes.description,
                                    textAlign: TextAlign.center,
                                    styleVariant:
                                        PSTextStyleVariant.headline2,
                                  ),
                                  format:
                                      PSPageHeaderTextUnderIconWidgetElementFormat
                                          .horizontal,
                                  fontWeight: FontWeight.w700,
                                  highlightedTexts: widget
                                      .attributes.highlightedDescriptionTexts,
                                  highlighterTextColor:
                                      const Color(0xFF262727),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (widget.attributes.isPrimaryCTAShow)
                          const SizedBox(height: _Constants.twenty),
                        if (widget.attributes.isPrimaryCTAShow)
                          InkWell(
                            onTap: () {
                              if (!isSecondaryCTAPressed ||
                                  !widget.attributes
                                      .primartCTADisableOnSecondaryCTAPressed) {
                                widget.attributes.onPrimaryCTAPressed?.call();
                              }
                            },
                            child: TextWithUnderline(
                              text: widget.attributes.primaryCTAText,
                              spaceBetweenTextAndUnderline: 1,
                            ),
                          ),
                        if (widget.attributes.isSecondaryCTAShow)
                          const SizedBox(height: _Constants.twenty),
                        if (widget.attributes.isSecondaryCTAShow)
                          Button(
                            primaryCtaEnabled: false,
                            primaryCTAText: '',
                            primaryCTABorderColor: const Color(0xFFC7BDBA),
                            primaryCTAColor: const Color(0xFFF4F2F1),
                            secondaryCtaEnabled: true,
                            secondaryCTAText:
                                widget.attributes.secondaryCTAText,
                            secondaryCTAColor: Colors.black,
                            secondaryCTABorderColor: Colors.black,
                            secondaryCTATextColor: Colors.white,
                            onConfirmTap: () {
                              widget.attributes.onSecondaryCTAPressed?.call();
                              setState(() {
                                isSecondaryCTAPressed = true;
                              });
                            },
                            showProgressEnabled: widget
                                .attributes.secondaryShowProgressEnabled,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}