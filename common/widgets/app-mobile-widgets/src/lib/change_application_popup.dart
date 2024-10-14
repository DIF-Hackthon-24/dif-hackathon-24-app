import 'package:core/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/spannable_text_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/custom_buttons.dart';
import 'package:widget_library/page_header_text_under_icon/page_header_text_under_icon_widget.dart';
import 'package:widget_library/page_header_text_under_icon/page_header_text_under_icon_widget_attributes.dart';
import 'package:widget_library/timer_widget.dart';

class _Constants {
  static const bottomSheetTheme = 'info-bottom-sheet-theme';
  static const double thirtyFive = 35;
  static const double twenty = 20;
  static const double tenPixels = 10;
  static const double thirty = 30;
  static const threeFiveZero = 350;
  static const double fifty = 50;
  static const double forty = 40;
  static const zeroPixels = 0.0;
  static const twoPixels = 2.0;
  static const onePixels = 1.0;
  static const twentyFive = 25.0;
  static const double fifteen = 15;
  static const double sixty = 60;
  static const double five = 5;
  static const Color button2BorderColor = Color.fromRGBO(51, 51, 51, 1);
  static const Color button2TextColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color defaultIconColor = Color.fromRGBO(220, 197, 190, 1);
  static const String defaultIconPath = 'widget_library:assets/images/ic_file_writing.png';
  static const Color defaultIconBackgroundColor = Color.fromRGBO(239, 228, 222, 1);
  static const String bulletinInfo = '\u2022 ';
  static const EMPTY_STRING = '';
}

class IconAttributes {
  final String iconPath;
  final Color? iconBackgroundColor;
  final Color? iconBorderColor;

  IconAttributes({this.iconBackgroundColor, this.iconBorderColor, required this.iconPath});
}

class HighlightedTextWidgetAttributes {
  final String title;
  final List<String> highlightedTexts;

  HighlightedTextWidgetAttributes({required this.title, required this.highlightedTexts});
}

class ItemValueAttribute {
  final TextAlign textAlign;
  final TextUIDataModel value;

  ItemValueAttribute({
    required this.value,
    this.textAlign = TextAlign.start,
  });
}

class SuccessBottomSheetAttributes {
  final String title;
  String description;
  String? buttonText;
  Key? buttonKey;
  Function? onPressed;

  SuccessBottomSheetAttributes({
    required this.title,
    this.description = '',
    this.buttonText,
    this.buttonKey,
    this.onPressed,
  });
}

class ShowModalBottomSheetInfoAttributes {
  final String? attemptsLeft;
  final double? height;
  final String? attemptsRemainingWarning;
  final String? title;
  final String? description;
  final String? warningDescription;
  final bool? showDescription;
  final bool? showWarningDescription;
  final bool? disableButtons;
  final bool? showBulletingInfo;
  final IconAttributes? iconAttributes;
  final Function()? confirmButtonOnTap;
  final String? primaryCTAText;
  final Key? primaryCTAKey;
  final String? secondaryCTAText;
  final Key? secondaryCTAKey;
  final bool? primaryCtaEnabled;
  final bool? secondaryCtaEnabled;
  final Function()? cancelButtonOnTap;
  final List<ItemValueAttribute>? itemValueAttributes;
  final HighlightedTextWidgetAttributes? highlightedTextWidgetAttributes;
  final bool? showSubDescription;
  final int? timerDurationInSeconds;
  Future<bool> Function()? onBackPressed;
  final SuccessBottomSheetAttributes? successAttributes;
  final bool? warningSheet;
  final String? underLinedText;
  final String? errorTitle;
  final String? traceId;
  final bool? isRtl;
  final bool? showProgressEnabled;
  bool? inactiveHeader;

  ShowModalBottomSheetInfoAttributes({
    this.attemptsLeft,
    this.attemptsRemainingWarning,
    this.height,
    this.title,
    this.description,
    this.showDescription,
    this.warningDescription,
    this.showWarningDescription,
    this.disableButtons,
    this.showBulletingInfo,
    this.iconAttributes,
    this.confirmButtonOnTap,
    this.cancelButtonOnTap,
    this.itemValueAttributes,
    this.primaryCTAText,
    this.primaryCTAKey,
    this.secondaryCTAText,
    this.secondaryCTAKey,
    this.highlightedTextWidgetAttributes,
    this.primaryCtaEnabled = true,
    this.secondaryCtaEnabled = true,
    this.showSubDescription,
    this.timerDurationInSeconds,
    this.onBackPressed,
    this.successAttributes,
    this.warningSheet,
    this.underLinedText,
    this.errorTitle,
    this.traceId,
    this.isRtl,
    this.showProgressEnabled = false,
    this.inactiveHeader = false,
  });
}

Widget? buildDescription(
  BuildContext context,
  String description,
  bool showSubDescription,
  bool? showBulletInfo,
) {
  // final totalHeight = MediaQuery.of(context).size.height;
  // final scaleFactor = MediaQuery.of(context).size.height / totalHeight;
  return PSText(
    text: TextUIDataModel(
      description,
      styleVariant: PSTextStyleVariant.headline6,
      textAlign: TextAlign.center,
    ),
  );
}

Widget? buildWarningDescription(
  BuildContext context,
  String warningDescription,
) {
  return PSText(
    text: TextUIDataModel(
      warningDescription,
      styleVariant: PSTextStyleVariant.headline5,
      textAlign: TextAlign.center,
    ),
  );
}

class _Title extends StatelessWidget {
  final String title;
  final String? description;
  final bool? showBulletInfo;
  final bool inactiveHeader;

  _Title({
    Key? key,
    required this.title,
    this.showBulletInfo,
    this.description,
    this.inactiveHeader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final scaleFactor = MediaQuery.of(context).size.height / totalHeight;
    return Column(
      children: [
        PSText(
          text: TextUIDataModel(
            title,
            styleVariant: inactiveHeader ? PSTextStyleVariant.headline4 : PSTextStyleVariant.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        description == null && showBulletInfo == false
            ? SizedBox(
                height: _Constants.twenty * scaleFactor,
              )
            : SizedBox(),
      ],
    );
  }
}

Widget? bulletinInfo(BuildContext context, final List<ItemValueAttribute?> itemValueAttributes) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ...List.generate(
        itemValueAttributes.length,
        (index) {
          final value = itemValueAttributes[index]!.value;
          return Padding(
            padding: const EdgeInsets.only(top: _Constants.twoPixels),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SpannedTextWidget(
                    textAlign: TextAlign.center,
                    texts: [
                      const TextUIDataModel(_Constants.bulletinInfo, styleVariant: PSTextStyleVariant.subtitle1),
                      value,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

class ChangeApplicationBottomSheet extends StatelessWidget {
  final ShowModalBottomSheetInfoAttributes? attributes;

  ChangeApplicationBottomSheet({Key? key, this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconAttributes = attributes?.iconAttributes;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Wrap(
        children: [
          PopScope(
            canPop: true,
            onPopInvoked: (isPop){
              if(attributes?.onBackPressed != null){
                attributes!.onBackPressed!.call();
              }
            },
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_Constants.twenty),
                    topRight: Radius.circular(_Constants.twenty),
                  ),
                  color: Colors.white,
                ),
                child: attributes?.successAttributes != null
                    ? successBottomSheet(context, attributes?.successAttributes, iconAttributes)
                    : mainBody(context, iconAttributes),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: long-method
  Widget mainBody(BuildContext context, IconAttributes? iconAttributes) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    final scaleFactor = MediaQuery.of(context).size.height / totalHeight;
    final scalewidthFactor = MediaQuery.of(context).size.width / totalWidth;
    final title = attributes?.title ?? '';
    final description = attributes?.description ?? '';
    final warningDescription = attributes?.warningDescription ?? _Constants.EMPTY_STRING;
    final showDescription = attributes?.showDescription ?? false;
    final showWarningDescription = attributes?.showWarningDescription ?? false;
    final disableButtons = attributes?.disableButtons ?? false;
    final itemValueAttributes = attributes?.itemValueAttributes;
    final showBulletInfo = attributes?.showBulletingInfo ?? false;
    final onConfirmButtonTap = attributes?.confirmButtonOnTap;
    final onCancelButtonTap = attributes?.cancelButtonOnTap;
    final primaryCTAText = attributes?.primaryCTAText;
    final primaryCTAKey = attributes?.primaryCTAKey;
    final secondaryCTAText = attributes?.secondaryCTAText;
    final secondaryCTAKey = attributes?.secondaryCTAKey;
    final primaryCtaEnabled = attributes?.primaryCtaEnabled;
    final secondaryCtaEnabled = attributes?.secondaryCtaEnabled;
    final showProgressEnabled = attributes?.showProgressEnabled??false;
    final showSubDescription = attributes?.showSubDescription ?? showDescription;
    final timerDurationInSeconds = attributes?.timerDurationInSeconds;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.maxFinite * scalewidthFactor,
              height: _Constants.thirtyFive * scaleFactor,
            ),
            SizedBox(
              height: _Constants.twentyFive * scaleFactor,
            ),
            attributes?.attemptsLeft != null && attributes!.attemptsLeft!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: _Constants.fifteen, bottom: _Constants.twenty),
                    child: Container(
                      child: PSText(
                        text: TextUIDataModel(
                          attributes?.attemptsLeft ?? '',
                          styleVariant: PSTextStyleVariant.subtitle2,
                        ),
                      ),
                    ),
                  )
                : Container(),
            attributes?.attemptsRemainingWarning != null && attributes!.attemptsRemainingWarning!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: _Constants.five,
                      bottom: _Constants.twenty,
                      left: _Constants.twenty,
                      right: _Constants.twenty,
                    ),
                    child: Container(
                      child: PSText(
                        text: TextUIDataModel(
                          attributes?.attemptsRemainingWarning ?? '',
                          styleVariant: PSTextStyleVariant.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : Container(),
            attributes?.title != null && attributes!.title!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: _Constants.twenty, right: _Constants.twenty),
                    child: _Title(
                      title: title,
                      description: attributes?.description,
                      showBulletInfo: attributes?.showBulletingInfo,
                      inactiveHeader: attributes?.inactiveHeader ?? false,
                    ),
                  )
                : Container(),
            showBulletInfo && itemValueAttributes.isNotEmptyOrNull
                ? Padding(
                    padding: const EdgeInsets.only(top: _Constants.twenty, bottom: _Constants.forty),
                    child: bulletinInfo(context, itemValueAttributes ?? []) ?? Container(),
                  )
                : Container(),
            showDescription && description.isNotEmptyOrNull
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: _Constants.twenty,
                      right: _Constants.twenty,
                      top: _Constants.twenty,
                    ),
                    child: buildDescription(
                          context,
                          description,
                          showSubDescription,
                          showBulletInfo,
                        ) ??
                        Container(),
                  )
                : Container(),
            showWarningDescription && warningDescription.isNotEmptyOrNull
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: _Constants.twenty, right: _Constants.twenty),
                    child: buildWarningDescription(
                          context,
                          warningDescription,
                        ) ??
                        Container(),
                  )
                : Container(),
            _underLinedText(),
            _errorTexts(context),
            showSubDescription
                ? Padding(
                    padding: const EdgeInsets.only(top: _Constants.fifteen),
                    child: _brokenTexts(
                          context,
                          scalewidthFactor,
                        ) ??
                        Container(),
                  )
                : SizedBox(
                    height: _Constants.twenty,
                  ),
            timerDurationInSeconds != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      bottom: _Constants.thirty,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: TimerWidget(
                        durationInSeconds: timerDurationInSeconds,
                      ),
                    ),
                  )
                : Container(),
            if (!disableButtons)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: _Constants.tenPixels),
                  child: Button(
                    primaryCTAText: primaryCTAText ?? '',
                    primaryCTAKey: primaryCTAKey,
                    primaryCTAColor: PSTheme().themeFor(_Constants.bottomSheetTheme).colorScheme
                        .background,
                    primaryCTABorderColor: PSTheme().themeFor(_Constants.bottomSheetTheme).primaryColorLight,
                    secondaryCTATextColor: _Constants.button2TextColor,
                    secondaryCTAText: secondaryCTAText ?? '',
                    secondaryCTAKey: secondaryCTAKey,
                    secondaryCTAColor: Colors.black,
                    secondaryCTABorderColor: _Constants.button2BorderColor,
                    onConfirmTap: onConfirmButtonTap,
                    onCancelTap: onCancelButtonTap,
                    primaryCtaEnabled: primaryCtaEnabled,
                    secondaryCtaEnabled: secondaryCtaEnabled,
                    showProgressEnabled:showProgressEnabled,
                  ),
                ),
              ),
          ],
        ),
        icon(context, iconAttributes),
      ],
    );
  }

  Widget successBottomSheet(
    BuildContext context,
    SuccessBottomSheetAttributes? attributes,
    IconAttributes? iconAttributes,
  ) {
    if (attributes != null) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: _Constants.twenty,
                    right: _Constants.twenty,
                    top: _Constants.sixty,
                    bottom: _Constants.forty,
                  ),
                  child: PSText(
                    text: TextUIDataModel(
                      attributes.title,
                      textAlign: TextAlign.center,
                      styleVariant: PSTextStyleVariant.headline5,
                    ),
                  ),
                ),
              ),
              getDescription(attributes),
              if (attributes.buttonText != null)
                Button(
                  primaryCTAText: '',
                  primaryCTAColor: PSTheme().themeFor(_Constants.bottomSheetTheme).colorScheme
                      .background,
                  primaryCTABorderColor: PSTheme().themeFor(_Constants.bottomSheetTheme).primaryColorLight,
                  secondaryCTATextColor: _Constants.button2TextColor,
                  secondaryCTAText: attributes.buttonText!,
                  secondaryCTAKey: attributes.buttonKey ?? Key('Success_popup_CTA'),
                  secondaryCTAColor: Colors.black,
                  secondaryCTABorderColor: _Constants.button2BorderColor,
                  onConfirmTap: attributes.onPressed,
                  //onCancelTap: onCancelButtonTap,
                  primaryCtaEnabled: false,
                  secondaryCtaEnabled: true,
                ),
            ],
          ),
          icon(
            context,
            iconAttributes,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget icon(BuildContext context, IconAttributes? iconAttributes) {
    final totalHeight = MediaQuery.of(context).size.height;
    final scaleFactor = MediaQuery.of(context).size.height / totalHeight;
    return Container(
      transform: Matrix4.translationValues(_Constants.zeroPixels, -_Constants.fifty, _Constants.zeroPixels),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          _Constants.twentyFive,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: iconAttributes?.iconBackgroundColor ?? _Constants.defaultIconColor,
            border: Border.all(
              width: _Constants.fifteen,
              color: iconAttributes?.iconBorderColor ?? _Constants.defaultIconBackgroundColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(_Constants.onePixels) * scaleFactor,
            child: PSImage(PSImageModel(
              iconPath: iconAttributes?.iconPath ?? _Constants.defaultIconPath,
              padding: const EdgeInsets.all(_Constants.fifteen) * scaleFactor,
            )),
          ),
        ),
      ),
    );
  }

  Widget _underLinedText() {
    if (attributes != null && attributes!.underLinedText.isNotEmptyOrNull) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: PSText(
          text: TextUIDataModel(
            attributes!.underLinedText!,
            styleVariant: PSTextStyleVariant.headline6,
            textAlign: TextAlign.center,
          ),
          isUnderLinedText: true,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _errorTexts(BuildContext context) {
    if ((attributes?.traceId ?? '').isNotEmpty) {
      return Center(
        child: Column(
          children: [
            PSText(
              text: TextUIDataModel(attributes!.errorTitle ?? '',
                  textAlign: TextAlign.center, styleVariant: PSTextStyleVariant.headline6),
            ),
            if (attributes!.errorTitle.isNotEmptyOrNull) SizedBox(height: 10),
            if (attributes!.traceId.isNotEmptyOrNull)
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: PSText(
                  text: TextUIDataModel(attributes!.traceId ?? '',
                      textAlign: TextAlign.center, styleVariant: PSTextStyleVariant.headline6,),
                ),
              ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget? _brokenTexts(
    BuildContext context,
    double scaleWidthFactor,
  ) {
    final totalHeight = MediaQuery.of(context).size.height;
    final scaleFactor = MediaQuery.of(context).size.height / totalHeight;
    final highlightedTextWidgetAttributes = attributes?.highlightedTextWidgetAttributes;
    return Column(
      children: [
        Container(
          width: _Constants.threeFiveZero * scaleWidthFactor,
          child: PSPageHeaderTextUnderIconWidget(
            attributes: PSPageHeaderTextUnderIconWidgetAttributes(
              headerBottomPadding: _Constants.zeroPixels,
              headerTopPadding: _Constants.zeroPixels,
              leftMargin: _Constants.thirty,
              rightMargin: _Constants.twenty,
              attributesList: [
                PSPageHeaderTextUnderIconWidgetElementAttributes(
                  title: TextUIDataModel(
                    highlightedTextWidgetAttributes != null ? highlightedTextWidgetAttributes.title : '',
                    textAlign: TextAlign.center,
                    styleVariant: PSTextStyleVariant.headline6,
                  ),
                  format: PSPageHeaderTextUnderIconWidgetElementFormat.horizontal,
                  highlightedTexts:
                      highlightedTextWidgetAttributes != null ? highlightedTextWidgetAttributes.highlightedTexts : [],
                  highlighterTextColor: Color(0xFF262727),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: _Constants.forty * scaleFactor,
        ),
      ],
    );
  }

  Widget getDescription(
    SuccessBottomSheetAttributes attributes,
  ) {
    return attributes.description.isNotEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: _Constants.twenty,
                right: _Constants.twenty,
                bottom: _Constants.forty,
              ),
              child: PSText(
                text: TextUIDataModel(
                  attributes.description,
                  textAlign: TextAlign.center,
                  styleVariant: PSTextStyleVariant.headline6,
                ),
              ),
            ),
          )
        : Container();
  }
}
