import 'dart:convert';

import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/docked_button.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/list_row/list_row_widget.dart';
import 'package:widget_library/list_row/list_row_widget_model.dart';

class _Constants {
  static const english = 'English';
  static const arabic = 'عربي';
  static const arabicAccessibility = 'Arabic Button double tap to activate';
  static const englishKey = 'en';
  static const arabicKey = 'ar';
  static const double twentyPixels = 20;
  static const double twentyTwoPixels = 22;
  static const double oneFortyPixels = 135;
  static const double fortyEightPixels = 48;
  static const double fortySixPixels = 46.5;
  static const double fortySevenPixels = 47;
  static const double fiftyPixels = 50;
  static const double tenPixels = 10;
  static const double fourPixels = 4;
  static const double sixPixels = 6;
  static const double thirtyFivePixels = 34;
  static const scaleFactor = 812;
  static const double onePixels = 1;
  static const double sixteen = 16;
  static const drawerWidth = 321;
  static const threeSeventyFive = 375;
  static const double onePointFive = 1.5;
  static const double eighteen = 18.0;
  static const fourEighty = 480;
  static const hundred = 100;
  // static const oneFifty = 150;
  static const personImagePath = 'assets/images/person.svg';
  static const personBackgroundImagePath = 'assets/images/profile_background.svg';
  static const backgroundIcon = 'assets/images/ic_hamburger_menu_bg_icon.svg';
  static const double zero = 0;
  static const double oneThirty = 130;
  static const double twentyEight = 28;
  static const double sixPointThreeTwo = 6.32;
  static const double sixtySevenPointOneFive = 67.15;
  static const double forty = 40;
  static const fontFamily = 'NotoSans';
  static const Color versionFontColor = Color(0xFF7A7C7C);
  static const double fivePixels = 5;
}

class CommonDrawerAttributes {
  final String? theme;
  String closeText;
  List<ListRowAttribute> drawerList;
  bool isRTL;
  Color? highlightedButtonColor;
  Color? dividerColor;
  String? backgroundImage;
  Function(String) onLanguagePressed;
  String? name;
  String? photo;
  String? helloText;
  String versionDetails;
  void Function()? onPhotoPressed;

  CommonDrawerAttributes({
    this.theme,
    required this.closeText,
    required this.drawerList,
    this.isRTL = false,
    required this.onLanguagePressed,
    this.dividerColor,
    this.backgroundImage,
    this.highlightedButtonColor,
    this.name,
    this.photo,
    this.helloText,
    this.onPhotoPressed,
    required this.versionDetails,
  });
}

class CommonDrawer extends StatefulWidget {
  final Function? drawerCallback;

  final CommonDrawerAttributes attributes;

  CommonDrawer({Key? key, required this.attributes, this.drawerCallback}) : super(key: key);

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  void initState() {
    super.initState();
    widget.drawerCallback!(true);
  }

  @override
  void dispose() {
    widget.drawerCallback!(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    final scaleheightFactor = totalHeight / _Constants.scaleFactor;
    final scaleWidthFactor = totalWidth / _Constants.threeSeventyFive;
    final isTablet = MediaQuery.of(context).size.width > _Constants.fourEighty;
    return Theme(
      data: PSTheme().themeFor(widget.attributes.theme),
      child: Drawer(
        key: widget.key,
        width: _Constants.drawerWidth * scaleWidthFactor,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: PSTheme().themeData.colorPalette?.tertiary.toColor(),
            ),
            PSImage(
              PSImageModel(
                iconPath: widget.attributes.backgroundImage ?? '',
                color: PSTheme().defaultTheme?.colorScheme.background,
              ),
            ),
            Positioned(
              right: widget.attributes.isRTL ? null : _Constants.zero,
              left: widget.attributes.isRTL ? _Constants.zero : null,
              top: _Constants.zero,
              child: PSImage(
                PSImageModel(iconPath: _Constants.backgroundIcon, width: _Constants.oneThirty),
              ),
            ),
            Wrap(
              children: [
                Semantics(
                  focusable: true,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: _Constants.thirtyFivePixels,
                      left: _Constants.fourPixels,
                      right: _Constants.sixPixels,
                    ),
                    child: ListTile(
                      key: const Key('Drawer_Close_CTA'),
                      minLeadingWidth: _Constants.twentyTwoPixels,
                      trailing: Icon(
                        Icons.close,
                        size: _Constants.twentyPixels,
                        color: PSTheme().themeData.colorPalette?.secondary.toColor(),
                        key: const Key('Drawer_Close_Icon'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: _Constants.twentyEight,
                      right: _Constants.twentyEight,
                     ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PSText(
                            text: TextUIDataModel(widget.attributes.helloText ?? ''),
                          ),
                          Container(
                            width: 165 * scaleWidthFactor,
                            child: PSText(
                              text: TextUIDataModel(widget.attributes.name ?? '',
                                  styleVariant: PSTextStyleVariant.headline1,
                                ),
                            ),
                          ),
                        ],
                      ),
                      widget.attributes.photo.isNotBlank()
                          ? GestureDetector(
                              onTap: () {
                                Scaffold.of(context).closeDrawer();
                                widget.attributes.onPhotoPressed?.call();
                              },
                              child: Container(
                                key: const Key('User_Image'),
                                margin: EdgeInsets.only(bottom: _Constants.fivePixels),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: _Constants.sixPointThreeTwo,
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
                                  height: _Constants.sixtySevenPointOneFive * scaleheightFactor,
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.memory(
                                    Base64Codec().decode(
                                      widget.attributes.photo!,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Scaffold.of(context).closeDrawer();
                                widget.attributes.onPhotoPressed?.call();
                              },
                              child: Container(
                                key: const Key('User_Image_Place_Holder'),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    PSImage(
                                      PSImageModel(
                                        iconPath: _Constants.personBackgroundImagePath,
                                        height: (MediaQuery.of(context).size.height / _Constants.scaleFactor) *
                                            _Constants.hundred,
                                      ),
                                    ),
                                    PSImage(
                                      PSImageModel(
                                        iconPath: _Constants.personImagePath,
                                        height: _Constants.forty,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Divider(
                  height: _Constants.onePixels,
                  thickness: _Constants.onePixels,
                  color: widget.attributes.dividerColor,
                ),
                isTablet
                    ? drawerListView()
                    : SizedBox(
                        height: (totalHeight - _Constants.hundred) * scaleheightFactor,
                        child: drawerListView(),
                      ),
              ],
            ),
            Align(
              alignment: widget.attributes.isRTL
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: _Constants.twentyPixels,
                  right: _Constants.twentyPixels,
                  left: _Constants.twentyPixels,
                ),
                child: Text(
                  widget.attributes.versionDetails,
                  style: TextStyle(
                    fontFamily: _Constants.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _Constants.versionFontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerListView() {
    final totalHeight = MediaQuery.of(context).size.height;
    final scaleheightFactor = totalHeight / _Constants.scaleFactor;
    return  SingleChildScrollView(
      child: SizedBox(
      height:( widget.attributes.drawerList.length +  widget.attributes.drawerList[0].subAdditionalDetailsRow!.length  ) * _Constants.fortySevenPixels * scaleheightFactor,
      child: ListView.separated(
        padding: EdgeInsets.only(top: _Constants.zero),
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: _Constants.onePixels,
          thickness: _Constants.onePixels,
          color: widget.attributes.dividerColor,
        ),
        itemBuilder: (context, index) => ListRowWidget(
          attribute: widget.attributes.drawerList[index],
          key: Key('Drawer_CTA_Item_$index'),
        ),
        itemCount: widget.attributes.drawerList.length,
      ),),
    );
  }

  Widget drawerList({String? title, String? iconPath, Function()? onTap}) {
    return ListTile(
      leading: PSImage(
        PSImageModel(iconPath: iconPath ?? ''),
      ),
      title: PSText(
        text: TextUIDataModel(title ?? ''),
      ),
      onTap: onTap,
    );
  }

  // ignore: long-method
  Widget getLanguageButtons(
    BuildContext context,
    bool isRTL,
    Function(String) onLanguagePressed,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: _Constants.eighteen,
          right: _Constants.eighteen,
          bottom: (MediaQuery.of(context).size.height * _Constants.twentyPixels) / _Constants.scaleFactor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isRTL
                    ? _getHighlightedButton(
                        _Constants.english,
                        () async {
                          await onLanguagePressed(_Constants.englishKey);
                        },
                        textColor: Colors.black,
                        width: _Constants.fortySixPixels,
                        buttonColor: PSTheme().themeFor(widget.attributes.theme).scaffoldBackgroundColor,
                        key: const Key('Language_English_CTA_Highlighted'),
                      )
                    : _getButton(
                        _Constants.english,
                        () async {
                          await onLanguagePressed(_Constants.englishKey);
                        },
                        width: _Constants.fortyEightPixels,
                        buttonColor: Colors.black,
                        key: const Key('Language_Arabic_CTA'),
                      ),
                SizedBox(
                  width: (MediaQuery.of(context).size.height * _Constants.tenPixels) / _Constants.scaleFactor,
                ),
                !isRTL
                    ? _getArabicHighlightedButton(
                        _Constants.arabic,
                        () async {
                          await onLanguagePressed(_Constants.arabicKey);
                        },
                        textColor: Colors.black,
                        width: _Constants.fortySixPixels,
                        buttonColor: PSTheme().themeFor(widget.attributes.theme).scaffoldBackgroundColor,
                        key: const Key('Language_Arabic_CTA_Highlighted'),
                      )
                    : _getButton(
                        _Constants.arabic,
                        () async {
                          await onLanguagePressed(_Constants.arabicKey);
                        },
                        width: _Constants.fortyEightPixels,
                        buttonColor: Colors.black,
                        key: const Key('Language_Arabic_CTA'),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: long-parameter-list
  Widget _getHighlightedButton(
    String text,
    Function onPressed, {
    Color? buttonColor,
    Color? textColor,
    double? width,
    Key? key,
  }) {
    return Container(
      key: key,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_Constants.fiftyPixels),
          side: BorderSide(
            color: widget.attributes.highlightedButtonColor!,
            width: _Constants.onePointFive,
          ),
        ),
      ),
      child: _getButton(
        text,
        onPressed,
        buttonColor: buttonColor,
        textColor: textColor,
        width: width,
      ),
    );
  }

  Widget _getArabicHighlightedButton(
    String text,
    Function onPressed, {
    Color? buttonColor,
    Color? textColor,
    double? width,
    Key? key,
  }) {
    return Semantics(
      focusable: true,
      label: _Constants.arabicAccessibility,
      child: Container(
        key: key,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_Constants.fiftyPixels),
            side: BorderSide(
              color: widget.attributes.highlightedButtonColor!,
              width: _Constants.onePointFive,
            ),
          ),
        ),
        child: ExcludeSemantics(
          excluding: true,
          child: _getButton(
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
      minimumSize: Size(_Constants.oneFortyPixels, width ?? _Constants.zero),
      cornerRadius: _Constants.fiftyPixels,
      title: text,
      textStyle: TextStyle(
        fontFamily: getButtonFont(),
        fontSize: _Constants.sixteen,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      onPressed: () async {
        await onPressed.call();
      },
    );
  }

  String getButtonFont() {
    final language = Localizations.localeOf(context).languageCode;
    return '${PSTheme().defaultTheme!.textTheme.bodyLarge!.fontFamily}${language == 'ar' ? 'Arabic' : ''}';
  }
}
