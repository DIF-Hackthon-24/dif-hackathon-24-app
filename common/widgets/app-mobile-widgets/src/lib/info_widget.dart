import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/ps_scaffold.dart';

class _Constants {
  static const double iconSize = 28.0;
  static const lineHeight = LineHeight(1.5);
}

class InfoWidgetAttributes {
  String htmlContent;
  String? themeName;
  bool isRTL;
  String title;

  InfoWidgetAttributes({
    required this.htmlContent,
    required this.themeName,
    this.isRTL = false,
    required this.title,
  });
}

// ignore: must_be_immutable
class InfoWidget extends StatelessWidget {
  final InfoWidgetAttributes attributes;

  InfoWidget({required this.attributes, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PSScaffold(
      themeName: attributes.themeName,
      appBarAttributes: PSAppBarAttributes(
        title: attributes.title,
        left: attributes.isRTL
            ? [
                PSAppBarButtonAttributes(
                  type: PSAppBarButtons.backArabic,
                  onPressed: () => NavigationManager.goBack(),
                  iconSize: _Constants.iconSize,
                ),
              ]
            : [
                PSAppBarButtonAttributes(
                  type: PSAppBarButtons.back,
                  onPressed: () => NavigationManager.goBack(),
                  iconSize: _Constants.iconSize,
                ),
              ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Html(
            data: attributes.htmlContent,
            style: {
              '*': Style(
                lineHeight: attributes.isRTL ? _Constants.lineHeight : null,
                fontFamily: getBodyFontFamily(context),
                fontWeight: FontWeight.w400,
              ),
              'h3,h4': Style(
                lineHeight: attributes.isRTL ?  _Constants.lineHeight : null,
                fontFamily: getHeadingFontFamily(context), fontWeight: FontWeight.w500,),
            },
          ),
        ),
      ),
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
