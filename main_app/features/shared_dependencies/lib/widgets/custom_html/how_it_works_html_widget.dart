import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:shared_dependencies/widgets/custom_html/html_widget_attributes.dart';

class _Constants {
  static const lineHeight = LineHeight(1.5);
  static const lineHeightArabic = 1.25;
  static const lineHeightEnglish = 1.1;
}

class HowItWorksHtmlWidget extends StatelessWidget {
  final HtmlWidgetAttributes attributes;

  const HowItWorksHtmlWidget({required this.attributes, super.key});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: attributes.htmlContent,
      style: {
        '*': Style(
            lineHeight: attributes.isRtl? LineHeight.em(_Constants.lineHeightArabic) : LineHeight.em(_Constants.lineHeightEnglish),
            fontFamily: getBodyFontFamily(context),
            fontWeight: FontWeight.w400,
            color: ColorConstants.COLOR_FF666869),
        'h3,h4': Style(
          lineHeight: attributes.isRtl ? _Constants.lineHeight : null,
          fontFamily: getHeadingFontFamily(context),
          fontWeight: FontWeight.w500,
          color: ColorConstants.COLOR_FF666869,
          margin: Margins.only(bottom: DimensionConstants.size10,top: DimensionConstants.size5)
        ),
        'b,strong': Style(
          lineHeight: attributes.isRtl ? _Constants.lineHeight : null,
          fontFamily: getHeadingFontFamily(context),
          fontWeight: FontWeight.w700,
          color: ColorConstants.COLOR_FF666869,
          margin: Margins.only(bottom: DimensionConstants.size10,top: DimensionConstants.size5)
        ),
        'ul,ol': Style(
          fontFamily: getBodyFontFamily(context),
          margin: Margins.only(
            left: attributes.isRtl? DimensionConstants.size0: DimensionConstants.size25,
            right: attributes.isRtl?  DimensionConstants.size25: DimensionConstants.size0,
            top: DimensionConstants.size10,
            bottom: DimensionConstants.size10,
          ),
          padding: HtmlPaddings.all(0),
          textAlign: TextAlign.start,
          listStylePosition: ListStylePosition.outside,
        ),
      },
    );
  }

  String getBodyFontFamily(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    return language == 'ar' ? 'NotoSansArabic' : 'NotoSans';
  }

  String getHeadingFontFamily(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    return language == 'ar' ? 'NotoSans-mediumArabic' : 'NotoSans-medium';
  }
}
