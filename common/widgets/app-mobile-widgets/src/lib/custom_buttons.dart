import 'dart:async';

import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';

class _Constants {
  static const containerHeight = 60;
  static const mobileHeight = 812;
  static const mobileWidth = 375;
  static const fivePixels = 5.0;
  static const double eight = 8.0;
  static const zeroPixels = 0.0;
  static const fortyPixels = 40;
  static const onePixel = 1.0;
  static const fiftyPixels = 50.0;
  static const sixteenPixels = 16.0;
  static const fontFamily = 'NotoSans-medium';
  static const arabicSuffix = 'Arabic';
  static const double size65 = 65;
  static const int ctaDisabledMilliseconds = 3000;
  static const int loaderShownMilliseconds = 5000;
  static const int loaderShownMillisecondsUndertaking = 10000;
}

class Button extends StatefulWidget {
  final String primaryCTAText;
  final Key? primaryCTAKey;
  final Color primaryCTAColor;
  final Color? primaryCTABorderColor;
  final Color? primaryCTATextColor;
  final Function? onConfirmTap;
  final Function? onCancelTap;
  final String secondaryCTAText;
  final Key? secondaryCTAKey;
  final Color secondaryCTAColor;
  final Color? secondaryCTABorderColor;
  final Color? secondaryCTATextColor;
  final bool? primaryCtaEnabled;
  final bool? secondaryCtaEnabled;
  final Size? primaryButtonSize;
  final Size? secondaryButtonSize;
  final String? secondaryButtonIcon;
  final bool? showProgressEnabled;
  final bool? secondaryCtaActive;
  final bool? isUnderLineText;
  final Color? secondaryButtonIconColor;
  final bool? enableButtonSpam;
  final Color? loaderColor;
  final FontWeight? primaryCTAFontWeight;
  final bool? isRtl;
  final bool? useFittedBox;
  final bool isFromUndertaking;
  final TextStyle? primaryTextStyle;
  final TextStyle? secondaryTextStyle;

  const Button({
    required this.primaryCTAText,
    this.primaryCTAKey,
    required this.primaryCTAColor,
    this.primaryCTABorderColor,
    this.primaryCTATextColor,
    required this.secondaryCTAText,
    this.secondaryCTAKey,
    required this.secondaryCTAColor,
    this.secondaryCTABorderColor,
    this.secondaryCTATextColor,
    this.onConfirmTap,
    this.onCancelTap,
    this.primaryCtaEnabled = true,
    this.secondaryCtaEnabled = true,
    this.primaryButtonSize,
    this.secondaryButtonSize,
    this.secondaryButtonIcon,
    this.showProgressEnabled=false,
    this.secondaryCtaActive = true,
    this.isUnderLineText = false,
    this.secondaryButtonIconColor,
    this.enableButtonSpam,
    this.loaderColor,
    this.primaryCTAFontWeight = FontWeight.w500,
    this.isRtl = false,
    this.useFittedBox,
    this.isFromUndertaking = false,
    this.primaryTextStyle,
    this.secondaryTextStyle,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isSingleTimeCancelPressed = true;
  bool _isSingleTimeConfirmPressed = true;
  bool _showProgressOnConfirmCTA=false;
  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.height / _Constants.mobileHeight;
    final scalewidthFactor = MediaQuery.of(context).size.width / _Constants.mobileWidth;
    final isTablet = MediaQuery.of(context).size.width > 480;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.primaryCtaEnabled ?? true)
            Container(
              padding: const EdgeInsets.all(_Constants.fivePixels),
              width: widget.primaryButtonSize != null
                  ? widget.primaryButtonSize!.width
                  : (MediaQuery.of(context).size.width - _Constants.fortyPixels) * scalewidthFactor,
              height: widget.primaryButtonSize != null
                  ? widget.primaryButtonSize!.height
                  : isTablet
                      ? _Constants.size65
                      : _Constants.containerHeight * scaleFactor,
              child: ElevatedButton(
                key: widget.primaryCTAKey,
                style: ElevatedButton.styleFrom(
                  elevation: _Constants.zeroPixels,
                  backgroundColor: widget.primaryCTAColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: widget.primaryCTABorderColor ?? widget.primaryCTAColor,
                      width: _Constants.onePixel,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(_Constants.fiftyPixels),
                  ),
                ),
                onPressed: () {
                  if(!_isSingleTimeCancelPressed){
                    return;
                  }
                  if (_isSingleTimeCancelPressed) {
                    if (widget.onCancelTap != null) {
                      widget.onCancelTap!.call();
                    } else {
                      NavigationManager.goBack();
                    }
                  }
                  if(mounted){
                  setState(() {
                    _isSingleTimeCancelPressed = false;
                  });
                  }
                  Future.delayed(const Duration(milliseconds: _Constants.ctaDisabledMilliseconds), () {
                    if(mounted){
                    setState(() {
                      _isSingleTimeCancelPressed = true;
                    });
                    }
                  });
                },
                child:
               widget.isUnderLineText !=null
                   &&  widget.isUnderLineText == true
                   && widget.isRtl != null
                   && widget.isRtl == true
                ? DecoratedBox(
                 decoration:  const BoxDecoration(
                   border: Border(
                     bottom: BorderSide(
                       width: _Constants.onePixel,
                     ),
                   ),
                 ),
                 child: widget.useFittedBox?? false?FittedBox(
                   child: Text(
                     widget.primaryCTAText,
                     style: widget.primaryTextStyle ?? TextStyle(
                       color: widget.primaryCTATextColor ?? Colors.black,
                       fontWeight: FontWeight.w500,
                       fontFamily: getFontFamily(context),
                       fontSize: _Constants.sixteenPixels,
                     ),
                   ),
                 ):Text(
                   widget.primaryCTAText,
                   style: widget.primaryTextStyle ?? TextStyle(
                     color: widget.primaryCTATextColor ?? Colors.black,
                     fontWeight: FontWeight.w500,
                     fontFamily: getFontFamily(context),
                     fontSize: _Constants.sixteenPixels,
                   ),
                 ),
               )
                :  widget.useFittedBox?? false?FittedBox(
                        child: Text(
                        widget.primaryCTAText,
                        style: widget.primaryTextStyle ?? TextStyle(
                          decoration: widget.isUnderLineText == true ? TextDecoration.underline : null,
                          color: widget.primaryCTATextColor ?? Colors.black,
                          fontWeight: widget.primaryCTAFontWeight,
                          fontFamily: getFontFamily(context),
                          fontSize: _Constants.sixteenPixels,
                        ),
                      )):Text(
                 widget.primaryCTAText,
                 style: widget.primaryTextStyle ?? TextStyle(
                   decoration: widget.isUnderLineText == true ? TextDecoration.underline : null,
                   color: widget.primaryCTATextColor ?? Colors.black,
                   fontWeight: widget.primaryCTAFontWeight,
                   fontFamily: getFontFamily(context),
                   fontSize: _Constants.sixteenPixels,
                 ),
               ),
              ),
            ),
          if (widget.secondaryCtaEnabled ?? true)
            Container(
              padding: const EdgeInsets.all(_Constants.fivePixels),
              width: widget.secondaryButtonSize != null
                  ? widget.secondaryButtonSize!.width
                  : (MediaQuery.of(context).size.width - _Constants.fortyPixels) * scalewidthFactor,
              height: widget.secondaryButtonSize != null
                  ? widget.secondaryButtonSize!.height
                  : isTablet
                      ? _Constants.size65
                      : _Constants.containerHeight * scaleFactor,
              child: ElevatedButton(
                key: widget.secondaryCTAKey,
                style: ElevatedButton.styleFrom(
                  elevation: _Constants.zeroPixels,
                  backgroundColor: widget.secondaryCTAColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: widget.secondaryCTABorderColor ?? widget.secondaryCTAColor,
                      width: _Constants.onePixel,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(_Constants.fiftyPixels),
                  ),
                ),
                onPressed: widget.onConfirmTap != null ? () {
                  if(widget.enableButtonSpam ?? false){
                    if (widget.onConfirmTap != null) {
                      widget.onConfirmTap!.call();
                    }
                  }else{
                  if(!_isSingleTimeConfirmPressed || !(widget.secondaryCtaActive ?? true)){
                    return;
                  }
                  if (_isSingleTimeConfirmPressed) {
                    if (widget.onConfirmTap != null) {
                      widget.onConfirmTap!.call();
                      
                    }
                  }
                  if(mounted){
                  setState(() {
                    _isSingleTimeConfirmPressed = false;
                    if(widget.showProgressEnabled??false){
                      _showProgressOnConfirmCTA=true;
                       Future.delayed(Duration(milliseconds: widget.isFromUndertaking ? _Constants.loaderShownMillisecondsUndertaking : _Constants.loaderShownMilliseconds),(){
                        if(mounted){
                          setState(() {
                            _showProgressOnConfirmCTA = false;
                          });
                        }
                       });

                    }
                  });
                  }
                
                  Future.delayed(const Duration(milliseconds:  _Constants.ctaDisabledMilliseconds), () {
                    if(mounted){
                    setState(() {
                      _isSingleTimeConfirmPressed = true;
                    });
                    }
                  });
                  }
                }:null,
                child: widget.useFittedBox??false?FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.secondaryCTAText,
                        style: widget.secondaryTextStyle ?? TextStyle(
                          color: widget.secondaryCTATextColor ?? Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: _Constants.sixteenPixels,
                          fontFamily: getFontFamily(context),
                        ),
                      ),
                      if (_showProgressOnConfirmCTA)
                      Padding(
                        padding: const EdgeInsets.all(_Constants.eight),
                        child:  SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: widget.loaderColor ?? Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      if (widget.secondaryButtonIcon != null && !_showProgressOnConfirmCTA)
                        Padding(
                          padding: const EdgeInsets.all(_Constants.eight),
                          child: PSImage(
                            PSImageModel(
                              iconPath: widget.secondaryButtonIcon!,
                              color: widget.secondaryButtonIconColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ): Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.secondaryCTAText,
                      style: widget.secondaryTextStyle ?? TextStyle(
                        color: widget.secondaryCTATextColor ?? Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: _Constants.sixteenPixels,
                        fontFamily: getFontFamily(context),
                      ),
                    ),
                    if (_showProgressOnConfirmCTA)
                      Padding(
                        padding: const EdgeInsets.all(_Constants.eight),
                        child:  SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: widget.loaderColor ?? Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    if (widget.secondaryButtonIcon != null && !_showProgressOnConfirmCTA)
                      Padding(
                        padding: const EdgeInsets.all(_Constants.eight),
                        child: PSImage(
                          PSImageModel(
                            iconPath: widget.secondaryButtonIcon!,
                            color: widget.secondaryButtonIconColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  String getFontFamily(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    return language == 'ar' ? '${_Constants.fontFamily}${_Constants.arabicSuffix}' : _Constants.fontFamily;
  }
}
