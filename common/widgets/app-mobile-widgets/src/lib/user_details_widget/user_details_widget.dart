import 'dart:convert';

import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/custom_buttons.dart';
import 'package:widget_library/user_details_widget/user_details_widget_attributes.dart';

class _Constants {
  static const personImagePath = 'assets/images/person.svg';
  static const personBackgroundImagePath = 'assets/images/profile_background.svg';
  static const fortyPixels = 40;
}

class _Sizes {
  static const double baseheight = 812;
  static const double baseWidth = 375;
  static const double seventyFour = 74;
  static const double five = 5;
  static const double sevenPointFive = 7.5;
  static const double fifty = 50;
  static const double eightyFive = 85;
  static const double hundred = 100;
  static const double twenty = 20;
  static const double twentyFour = 24;
  static const double forty = 40;
  static const double ten = 10;
  static const double sixtyFour = 64;
  static const double nintyFive = 95;
  static const double sixPointTwo = 6.2;
}

class UserDetailsWidget extends StatelessWidget {
  final UserDetailsWidgetAttributes attributes;

  const UserDetailsWidget({
    required this.attributes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.height / _Sizes.baseheight;
    final widthFactor = MediaQuery.of(context).size.width / _Sizes.baseWidth;
    bool isTablet = MediaQuery.of(context).size.width > 480;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: isTablet
                    ? MediaQuery.of(context).size.height / _Sizes.sixPointTwo
                    : scaleFactor * _Sizes.seventyFour,
              ),
              attributes.model?.image != null
                  ? Container(
                      key: const Key('User_Image'),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: scaleFactor * _Sizes.sevenPointFive,
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
                        height: _Sizes.eightyFive * scaleFactor,
                        clipBehavior: Clip.antiAlias,
                        child: Image.memory(
                          Base64Codec().decode(
                            attributes.model!.image!,
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
                              padding: EdgeInsets.all(_Sizes.ten),
                              iconPath: _Constants.personBackgroundImagePath,
                              height: scaleFactor * _Sizes.hundred,
                            ),
                          ),
                          PSImage(
                            PSImageModel(
                              padding: EdgeInsets.all(_Sizes.ten),
                              iconPath: _Constants.personImagePath,
                              height: scaleFactor * _Sizes.forty,
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: scaleFactor * _Sizes.five,
              ),
              PSText(
                key: const Key('Name_Label'),
                text: TextUIDataModel(
                  attributes.nameTextLabel ?? '',
                  textAlign: TextAlign.center,
                  styleVariant: PSTextStyleVariant.headline2,
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
                    attributes.model?.displayName ?? '',
                    textAlign: TextAlign.center,
                    styleVariant: PSTextStyleVariant.headline1,
                  ),
                ),
              ),
              SizedBox(
                height: scaleFactor * _Sizes.twenty,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: _Sizes.sixtyFour,
                  right: _Sizes.sixtyFour,
                ),
                child: PSText(
                  key: const Key('Description'),
                  text: TextUIDataModel(
                    attributes.description ?? '',
                    textAlign: TextAlign.center,
                    styleVariant: PSTextStyleVariant.bodyText2,
                  ),
                ),
              ),
              if (attributes.displayProfileScreen != true)
                SizedBox(
                  height: scaleFactor * _Sizes.twenty,
                ),
              Container(
                margin: EdgeInsets.only(
                  left: isTablet ? widthFactor * _Sizes.nintyFive : widthFactor * _Sizes.twenty,
                  right: isTablet ? widthFactor * _Sizes.nintyFive : widthFactor * _Sizes.twenty,
                ),
                decoration: BoxDecoration(
                  color: PSTheme().defaultTheme!.colorScheme.background,
                  borderRadius: BorderRadius.circular(_Sizes.ten),
                ),
                child: ListView(
                  key: const Key('Information_List'),
                  padding: EdgeInsets.fromLTRB(
                    _Sizes.twenty,
                    _Sizes.twentyFour,
                    _Sizes.twenty,
                    _Sizes.twentyFour,
                  ),
                  shrinkWrap: true,
                  children: [
                    PSText(
                      key: const Key('Name_Label'),
                      padding: Padding(
                        padding: EdgeInsets.only(
                          bottom: _Sizes.fifty,
                        ),
                      ),
                      text: TextUIDataModel(
                        attributes.nameLabel ?? '',
                        styleVariant: PSTextStyleVariant.headline4,
                      ),
                    ),
                    PSText(
                      key: const Key('User_Name'),
                      text: TextUIDataModel(
                        attributes.model?.userName ?? '',
                        styleVariant: PSTextStyleVariant.headline3,
                      ),
                    ),
                    SizedBox(
                      height: scaleFactor * _Sizes.twenty,
                    ),
                    PSText(
                      key: const Key('Contact_Number_Label'),
                      text: TextUIDataModel(
                        attributes.contactNumberLabel ?? '',
                        styleVariant: PSTextStyleVariant.headline4,
                      ),
                    ),
                    PSText(
                      key: const Key('Contact_Number'),
                      text: TextUIDataModel(
                        attributes.model?.phoneNumber ?? '',
                        styleVariant: PSTextStyleVariant.headline3,
                      ),
                    ),
                    SizedBox(
                      height: scaleFactor * _Sizes.twenty,
                    ),
                    if (attributes.emiratesIdLabel.isNotBlank())
                      PSText(
                        key: const Key('Emirates_ID_Label'),
                        text: TextUIDataModel(
                          attributes.emiratesIdLabel ?? '',
                          styleVariant: PSTextStyleVariant.headline4,
                        ),
                      ),
                    if (attributes.model != null && attributes.model!.emiratesId.isNotBlank())
                      PSText(
                        key: const Key('Emirates_Id'),
                        text: TextUIDataModel(
                          attributes.model?.emiratesId ?? '',
                          styleVariant: PSTextStyleVariant.headline3,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _getButtonList(context),
          ),
        ],
      ),
    );
  }

  Widget _getButtonList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: _Sizes.twenty,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: attributes.bottomButtonAttributes!.map((e) => _getButton(context, e)).toList(),
      ),
    );
  }

  Widget _getButton(
    BuildContext context,
    BottomButtonAttributes buttonAttributes,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - _Constants.fortyPixels,
      child: Button(
        primaryCTAText: '', 
        primaryCtaEnabled: false,
        primaryCTAColor: Colors.white, 
        secondaryCTAText: buttonAttributes.text, 
        secondaryCTATextColor: Colors.white,
        secondaryCTAKey: const Key('Continue_CTA'),
        secondaryCTAColor: Colors.black,
        onConfirmTap: ()async{
           buttonAttributes.onPressed.call();
        },
        ),
    );
  }

  String getButtonFontStyle(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    return language == 'ar'
        ? '${PSTheme().defaultTheme!.textTheme.bodyLarge!.fontFamily}Arabic'
        : PSTheme().defaultTheme!.textTheme.bodyLarge!.fontFamily!;
  }
}
