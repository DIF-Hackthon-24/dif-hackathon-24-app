import 'dart:convert';
import 'package:core/media_query/ps_media_query.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/docked_button.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/user_details_widget/profile_details_widget_attributes.dart';

class _Constants {
  static const myApplicationsImagePath = 'assets/images/icn_my_applications.svg';
  static const personImagePath = 'assets/images/person_icon.svg';
  static const personBlurImagePath = 'assets/images/blur_person.svg';
  static const nextImagePath = 'assets/images/point_next.svg';
  static const prevImagePath='assets/images/point_previous.svg';
  static const nextBlurImagePath = 'assets/images/blur_point_next.svg';
  static const prevBlurImagePath='assets/images/blur_point_previous.svg';
  static const personBackgroundImagePath = 'assets/images/profile_background.svg';
  static const languageImagePath = 'assets/icons/language.svg';
  static const logoutImage = 'assets/icons/log_out_icon.svg';
  static const languageText = 'Language';
  static const logoutText = 'logout';
  static const themeName = 'profilepage';
  static const english = 'English';
  static const arabic = 'عربي';
  static const englishKey = 'en';
  static const arabicKey = 'ar';
  static const double fortyEightPixels = 48;
  static const double fortySixPixels = 46.5;
  static const double tenPixels = 10;
  static const double fourPixels = 4;
  static const double zeroPixels = 0;
  static const double sixteen = 12;
  static const Color backGroundColor = Color(0xFFEDEAE9);
}

class _Sizes {
  static const double five = 5;
  static const double sevenPointFive = 7.5;
  static const double hundred = 100;
  static const double twenty = 20;
  static const double forty = 40;
  static const double ten = 10;
  static const double nintyFive = 95;
  static const double fifteen = 15;
  static const double sixtySevenPointOneFive = 67.15;
  static const double one = 1;
  static const double twentyFive = 25;
  static const double thirtyFive = 35;
  static const double sixtyFour = 64;
}

class ProfileDetailsWidget extends StatefulWidget {
  final ProfileDetailsWidgetAttributes attributes;

  const ProfileDetailsWidget({
    required this.attributes,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileDetailsWidget> createState() => _ProfileDetailsWidgetState();
}

class _ProfileDetailsWidgetState extends State<ProfileDetailsWidget> {
  bool isLoading=false;
  bool isRtl=false;
  @override
  Widget build(BuildContext context) {
   checkIfDataLoaded();
    final scaleFactorHeight = PSMediaQuery.scaleFactorHeight;
    final scalFactorWidth = PSMediaQuery.scaleFactorWidth;
    bool isTablet = PSMediaQuery.isTablet;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: _Sizes.twenty),
            padding: EdgeInsets.only(left: _Sizes.fifteen, right: _Sizes.fifteen,  bottom: _Sizes.twentyFive),
            color: _Constants.backGroundColor,
            child: Row(
              children: [
                widget.attributes.model?.image != null
                    ? Container(
                        key: const Key('User_Image'),
                        margin: EdgeInsets.only(top: _Constants.tenPixels),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: scaleFactorHeight * _Sizes.sevenPointFive,
                            color: PSTheme().themeFor('drawer').primaryColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: _Sizes.sixtySevenPointOneFive * scaleFactorHeight,
                          clipBehavior: Clip.antiAlias,
                          child: Image.memory(
                            Base64Codec().decode(
                              widget.attributes.model!.image!,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        key: const Key('User_Image_Place_Holder'),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            PSImage(
                              PSImageModel(
                                iconPath: _Constants.personBackgroundImagePath,
                                height: scaleFactorHeight * _Sizes.hundred,
                              ),
                            ),
                            PSImage(
                              PSImageModel(
                                iconPath: _Constants.personImagePath,
                                height: scaleFactorHeight * _Sizes.forty,
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: scaleFactorHeight * _Sizes.five,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: _Sizes.twenty,
                          right: _Sizes.twenty,
                        ),                      child: PSText(
                          key: const Key('Name_Label'),
                          text: TextUIDataModel(
                            widget.attributes.nameTextLabel ?? '',
                            textAlign: TextAlign.center,
                            styleVariant: PSTextStyleVariant.headline2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: _Sizes.twenty,
                          right: _Sizes.twenty,
                        ),
                        child: PSText(
                          key: const Key('Name'),
                          text: TextUIDataModel(
                            widget.attributes.model?.displayName ?? '',
                            textAlign: TextAlign.start,
                            styleVariant: PSTextStyleVariant.headline1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.attributes.isProfileExist == true
              ? GestureDetector(
                  onTap: () {
                    widget.attributes.profileButtonAttributes?.onProfilePressed.call();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
                      right: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal:_Sizes.twenty,
                    ),
                    height: _Sizes.sixtyFour,
                    decoration: BoxDecoration(
                      color: PSTheme().defaultTheme!.colorScheme.background,
                      borderRadius: BorderRadius.circular(_Sizes.ten),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Row(
                            children: [
                              PSImage(
                                PSImageModel(iconPath: _Constants.personImagePath),
                              ),
                              SizedBox(
                                width: scaleFactorHeight * _Sizes.twenty,
                              ),
                              PSText(
                                text: TextUIDataModel(widget.attributes.personalDetailsTextLabel ?? ''),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: widget.attributes.isRTL?? false? Alignment.centerLeft:Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(_Sizes.five),
                            child: PSImage(
                              PSImageModel(iconPath: widget.attributes.isRTL?? false?_Constants.prevImagePath:_Constants.nextImagePath,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    widget.attributes.profileButtonAttributes?.onProfileAlertPressed.call();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
                      right: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal:_Sizes.twenty,
                    ),
                    height: _Sizes.sixtyFour,
                    decoration: BoxDecoration(
                      color: PSTheme().defaultTheme!.colorScheme.background,
                      borderRadius: BorderRadius.circular(_Sizes.ten),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Row(
                            children: [
                              PSImage(
                                PSImageModel(iconPath: _Constants.personBlurImagePath),
                              ),
                              SizedBox(
                                width: scaleFactorHeight * _Sizes.twenty,
                              ),
                              Text(
                                widget.attributes.personalDetailsTextLabel ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Noto Sans',
                                    fontSize: 14,
                                  ),
                              ),

                            ],
                          ),
                        ),
                        Align(
                          alignment: widget.attributes.isRTL?? false? Alignment.centerLeft:Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(_Sizes.five),
                            child: PSImage(
                              PSImageModel(iconPath: widget.attributes.isRTL?? false?_Constants.prevBlurImagePath:_Constants.nextBlurImagePath),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          if (widget.attributes.isNEProfile == false)
            Padding(
              padding: EdgeInsets.only(
                top: scaleFactorHeight * _Sizes.twenty,
              ),
              child: widget.attributes.isProfileExist ?? false
                  ? GestureDetector(
                      onTap: () {
                        widget.attributes
                            .profileButtonAttributes?.onMyApplicationsPressed
                            .call();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: isTablet
                              ? scalFactorWidth * _Sizes.nintyFive
                              : scalFactorWidth * _Sizes.twenty,
                          right: isTablet
                              ? scalFactorWidth * _Sizes.nintyFive
                              : scalFactorWidth * _Sizes.twenty,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal:_Sizes.twenty,
                        ),
                        height: _Sizes.sixtyFour,
                        decoration: BoxDecoration(
                          color: PSTheme().defaultTheme!.colorScheme.background,
                          borderRadius: BorderRadius.circular(_Sizes.ten),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Row(
                                children: [
                                  PSImage(
                                    PSImageModel(
                                        iconPath:
                                            _Constants.myApplicationsImagePath),
                                  ),
                                  SizedBox(
                                    width: scaleFactorHeight * _Sizes.twenty,
                                  ),
                                  PSText(
                                    text: TextUIDataModel(
                                        widget.attributes.myApplicationsTextLabel ?? ''),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: widget.attributes.isRTL ?? false
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(_Sizes.five),
                                child: PSImage(
                                  PSImageModel(
                                    iconPath: widget.attributes.isRTL ?? false
                                        ? _Constants.prevImagePath
                                        : _Constants.nextImagePath,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        widget.attributes
                            .profileButtonAttributes?.onProfileAlertPressed
                            .call();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: isTablet
                              ? scalFactorWidth * _Sizes.nintyFive
                              : scalFactorWidth * _Sizes.twenty,
                          right: isTablet
                              ? scalFactorWidth * _Sizes.nintyFive
                              : scalFactorWidth * _Sizes.twenty,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal:_Sizes.twenty,
                        ),
                        height: _Sizes.sixtyFour,
                        decoration: BoxDecoration(
                          color: PSTheme().defaultTheme!.colorScheme.background,
                          borderRadius: BorderRadius.circular(_Sizes.ten),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Row(
                                children: [
                                  PSImage(
                                    PSImageModel(
                                      iconPath:
                                          _Constants.myApplicationsImagePath,
                                      color: const Color(0xFFB07A5C)
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: scaleFactorHeight * _Sizes.twenty,
                                  ),
                                  Text(
                                    widget.attributes.myApplicationsTextLabel ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Noto Sans',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: widget.attributes.isRTL ?? false
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(_Sizes.five),
                                child: PSImage(
                                  PSImageModel(
                                      iconPath: widget.attributes.isRTL ?? false
                                          ? _Constants.prevBlurImagePath
                                          : _Constants.nextBlurImagePath),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          SizedBox(
            height: scaleFactorHeight * _Sizes.twenty,
          ),
          Container(
            margin: EdgeInsets.only(
              left: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
              right: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: _Sizes.twenty,
            ),
            height: _Sizes.sixtyFour,
            decoration: BoxDecoration(
              color: PSTheme().defaultTheme!.colorScheme.background,
              borderRadius: BorderRadius.circular(_Sizes.ten),
            ),
            child: Row(
              children: [
                PSImage(
                  PSImageModel(iconPath: _Constants.languageImagePath),
                ),
                SizedBox(
                  width: scaleFactorHeight * _Sizes.twenty,
                ),
                Expanded(
                  child: PSText(
                    text: TextUIDataModel(widget.attributes.languageTextLabel ?? _Constants.languageText),
                  ),
                ),
                getLanguageButtons(
                  isLoading,
                  context,
                  widget.attributes.isRTL ?? false,
                ),
              ],
            ),
          ),
          SizedBox(
            height: scaleFactorHeight * _Sizes.twenty,
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(
                left: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
                right: isTablet ? scalFactorWidth * _Sizes.nintyFive : scalFactorWidth * _Sizes.twenty,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: _Sizes.twenty,
              ),
              height: _Sizes.sixtyFour,
              decoration: BoxDecoration(
                color: PSTheme().defaultTheme!.colorScheme.background,
                borderRadius: BorderRadius.circular(_Sizes.ten),
              ),
              child: Row(
                children: [
                  PSImage(
                    PSImageModel(iconPath: _Constants.logoutImage),
                  ),
                  SizedBox(
                    width: scaleFactorHeight * _Sizes.twenty,
                  ),
                  PSText(
                    text: TextUIDataModel(widget.attributes.logoutTextLabel ?? _Constants.logoutText),
                  ),
                ],
              ),
            ),
            onTap: () async {
              await widget.attributes.profileButtonAttributes?.onLogOutPressed.call();
            },
          ),
        ],
      ),
    );
  }

  Widget getLanguageButtons(
      bool isLoading,
    BuildContext context,
    bool isRTL,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: (isLoading)
          ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
          : IntrinsicWidth(
            child: Container(
                height: _Sizes.thirtyFive,
                decoration: BoxDecoration(
                  color: PSTheme()
                      .themeFor(_Constants.themeName)
                      .appBarTheme
                      .backgroundColor,
                  borderRadius: BorderRadius.circular(_Sizes.five),
                ),
                padding: EdgeInsets.all(_Sizes.five),
                child: isRTL
                    ? rowForArabicFirst(context, isRTL)
                    : rowForEnglishFirst(context, isRTL),
              ),
          ),
    );
  }

  Widget rowForEnglishFirst( BuildContext context,
    bool isRTL,){
    return Row(
          children: [
            !isRTL
                ? _getHighlightedButton(
                    context,
                    _Constants.english,
                    () async {
                   // setLoading(isRTL);
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.englishKey);
                    },
                    textColor: Colors.white,
                    width: _Constants.fortySixPixels,
                    buttonColor: Colors.black,
                    key: const Key('Language_English_CTA_Highlighted'),
                  )
                : _getButton(
                    context,
                    _Constants.english,
                    () async {
                      setLoading(isRTL);
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.englishKey);
                    },
                    width: _Constants.fortyEightPixels,
                    textColor: Colors.black,
                    buttonColor: PSTheme().themeFor(_Constants.themeName).appBarTheme.backgroundColor,
                    key: const Key('Language_Arabic_CTA'),
                  ),
            isRTL
                ? _getArabicHighlightedButton(
                    context,
                    _Constants.arabic,
                    () async {
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.arabicKey);
                    },
                    textColor: Colors.white,
                    width: _Constants.fortySixPixels,
                    buttonColor: Colors.black,
                    key: const Key('Language_Arabic_CTA_Highlighted'),
                  )
                : _getButton(
                    context,
                    _Constants.arabic,
                    () async {
                      setLoading(isRTL);
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.arabicKey);
                    },
                    width: _Constants.fortyEightPixels,
                    buttonColor: PSTheme().themeFor(_Constants.themeName).appBarTheme.backgroundColor,
                    textColor: Colors.black,
                    key: const Key('Language_Arabic_CTA'),
                  ),
          ],
        );
  }

  Widget rowForArabicFirst( BuildContext context,
    bool isRTL,){
        return Row(
          children: [
            isRTL
                ? _getArabicHighlightedButton(
                    context,
                    _Constants.arabic,
                    () async {
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.arabicKey);
                    },
                    textColor: Colors.white,
                    width: _Constants.fortySixPixels,
                    buttonColor: Colors.black,
                    key: const Key('Language_Arabic_CTA_Highlighted'),
                  )
                : _getButton(
                    context,
                    _Constants.arabic,
                    () async {
                      setLoading(isRTL);
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.arabicKey);
                    },
                    width: _Constants.fortyEightPixels,
                    buttonColor: PSTheme().themeFor(_Constants.themeName).appBarTheme.backgroundColor,
                    textColor: Colors.black,
                    key: const Key('Language_Arabic_CTA'),
                  ),
                  !isRTL
                ? _getHighlightedButton(
                    context,
                    _Constants.english,
                    () async {
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.englishKey);
                    },
                    textColor: Colors.white,
                    width: _Constants.fortySixPixels,
                    buttonColor: Colors.black,
                    key: const Key('Language_English_CTA_Highlighted'),
                  )
                : _getButton(
                    context,
                    _Constants.english,
                    () async {
                      setLoading(isRTL);
                      await widget.attributes.profileButtonAttributes?.onLanguagePressed.call(_Constants.englishKey);
                    },
                    width: _Constants.fortyEightPixels,
                    textColor: Colors.black,
                    buttonColor: PSTheme().themeFor(_Constants.themeName).appBarTheme.backgroundColor,
                    key: const Key('Language_Arabic_CTA'),
                  ),
          ],
        );
  }

  // ignore: long-parameter-list
  Widget _getHighlightedButton(
    BuildContext context,
    String text,
    Function onPressed, {
    Color? buttonColor,
    Color? textColor,
    double? width,
    Key? key,
  }) {
    return Container(
      key: key,
      padding: EdgeInsets.all(_Sizes.one),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_Constants.tenPixels),
        ),
      ),
      child: _getButton(
        context,
        text,
        onPressed,
        buttonColor: buttonColor,
        textColor: textColor,
        width: width,
      ),
    );
  }

  Widget _getArabicHighlightedButton(
    BuildContext context,
    String text,
    Function onPressed, {
    Color? buttonColor,
    Color? textColor,
    double? width,
    Key? key,
  }) {
    return Semantics(
      focusable: true,
      child: Container(
        padding: EdgeInsets.all(_Sizes.one),
        key: key,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_Constants.tenPixels),
          ),
        ),
        child: ExcludeSemantics(
          excluding: true,
          child: _getButton(
            context,
            text,
            onPressed,
            buttonColor: buttonColor,
            textColor: textColor,
            width: width,
          ),
        ),
      ),
    );
  }

  // ignore: long-parameter-list
  Widget _getButton(
    BuildContext context,
    String text,
    Function onPressed, {
    Color? buttonColor,
    Color? textColor,
    double? width,
    Key? key,
  }) {
    return PSDockedButton(
      key: key,
      buttonColor: buttonColor,
      minimumSize: Size(_Sizes.twenty, _Sizes.twentyFive),
      cornerRadius: _Constants.fourPixels,
      buttonPadding: _Constants.zeroPixels,
      title: text,
      textStyle: TextStyle(
        fontFamily: getButtonFont(context),
        fontSize: _Constants.sixteen,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1,
      ),
      onPressed: () async {
        await onPressed.call();
      },
    );
  }

  String getButtonFont(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    return '${PSTheme().defaultTheme!.textTheme.bodyLarge!.fontFamily}${language == 'ar' ? 'Arabic' : ''}';
  }

  void setLoading(isRTL) {
    setState(() {
      isLoading=(isRtl==isRTL);

    });
  }

  void checkIfDataLoaded() {
    setState(() {
      if(!isLoading){
        isRtl=widget.attributes.isRTL!;
      }else if( isLoading && (isRtl!=widget.attributes.isRTL)){
        isLoading=false;
      }

    });
  }
}

