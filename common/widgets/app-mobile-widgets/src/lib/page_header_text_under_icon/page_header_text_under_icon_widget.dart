import 'package:core/translation/app_localization.dart';
import 'package:core/utils/extensions/list_extensions.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

import 'page_header_text_under_icon_widget_attributes.dart';

/// This widget allows you to build header with or without icon.
/// It enables highlighting any part of the text. To do that pass [PSPageHeaderTextUnderIconWidgetElementAttributes.highlightedTexts] argument containing text to highlight.
/// Notice that [PSPageHeaderTextUnderIconWidgetElementAttributes.title] must contain full title including highlighted parts.
class PSPageHeaderTextUnderIconWidget extends StatelessWidget {
  final PSPageHeaderTextUnderIconWidgetAttributes attributes;
  final MainAxisAlignment mainAxisAlignment;

  const PSPageHeaderTextUnderIconWidget({
    Key? key,
    required this.attributes,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('PSPageHeaderTextUnderIconWidget_ContainerWidget'),
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.only(left: attributes.leftMargin, right: attributes.rightMargin),
      child: _BodyWidget(context: context, attributes: attributes, mainAxisAlignment: mainAxisAlignment),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key, required this.context, required this.attributes, required this.mainAxisAlignment})
      : super(key: key);

  final BuildContext context;
  final PSPageHeaderTextUnderIconWidgetAttributes attributes;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final widgetsList = <Widget>[];

    widgetsList.add(
      SizedBox(
        key: Key('PSPageHeaderTextUnderIconWidget_bodyWidgetsList_SizedBox'),
        height: attributes.headerTopPadding,
      ),
    );
    var counter = 1;
    for (var attr in attributes.attributesList) {
      TextStyle? textStyle;
      if (attr.title != null) {
        textStyle = buildTextStyle(context: context, variant: attr.title?.styleVariant ?? PSTextStyleVariant.headline2);
      }

      if (attr.format == PSPageHeaderTextUnderIconWidgetElementFormat.horizontal) {
        final rowItems = <Widget>[];

        if (attr.title != null) {
          rowItems.add(
            Flexible(
              child: Padding(
                padding: attr.padding?.toEdgeInsets() ?? EdgeInsets.zero,
                child: RichText(
                  textAlign: attr.title?.textAlign ?? TextAlign.start,
                  text: TextSpan(children: _buildHighlighters(context, attr, textStyle!)),
                ),
              ),
            ),
          );
        }

        if (attr.icon != null) {
          rowItems.add(
            Padding(
              key: Key('PSPageHeaderTextUnderIconWidget_bodyWidgetsList_Padding'),
              padding: EdgeInsets.only(left: attr.padding?.left ?? 0),
              child: _IconWidget(context: context, attr: attr),
            ),
          );
        }

        widgetsList.add(Row(mainAxisAlignment: mainAxisAlignment, children: rowItems));
      } else {
        if (attr.icon != null) {
          widgetsList.add(
            Padding(
              key: Key('PSPageHeaderTextUnderIconWidget_bodyWidgetsList_LeftPadding_ $counter'),
              padding: EdgeInsets.only(left: attr.padding?.left ?? 8),
              child: _IconWidget(context: context, attr: attr),
            ),
          );
          widgetsList.add(
            SizedBox(
              key: Key('PSPageHeaderTextUnderIconWidget_AfterPaddingSizedBox_ ${counter++}'),
              height: (attr.padding != null) ? attr.padding!.bottom : 31,
            ),
          );
        }
        if (attr.title != null) {
          final text = Padding(
            padding: attr.padding?.toEdgeInsets() ?? EdgeInsets.zero,
            child: RichText(text: TextSpan(children: _buildHighlighters(context, attr, textStyle!))),
          );

          widgetsList.add(text);
        }
      }
    }

    widgetsList.add(
      SizedBox(key: Key('PSPageHeaderTextUnderIconWidget_AfterSizedBox'), height: attributes.headerBottomPadding),
    );

    return Column(
      crossAxisAlignment: attributes.crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widgetsList,
    );
  }

  List<TextSpan> _buildHighlighters(
    BuildContext context,
    PSPageHeaderTextUnderIconWidgetElementAttributes attr,
    TextStyle textStyle,
  ) {
    final localization = AppLocalizations.of(context)!;
    List<TextSpan>? textSpans = [];
    final newTextStyle = textStyle.copyWith(
      color: attr.highlighterTextColor ?? PSTheme().defaultThemeData.highlightTextColor.toColor(),
      fontFamily: getMediumFontFamily(),
      fontWeight: attr.fontWeight ?? FontWeight.w500,
    );

    var originalText = attr.title?.text ?? '';

    if (attr.highlightedTexts.isBlank()) {
      textSpans.add(TextSpan(text: localization.translate(originalText), style: textStyle));
    } else {
      final highlighterTextSpans = attr.highlightedTexts!
        .map((highlightedText) {
            if (highlightedText.isBlank()) {
              return [const TextSpan(text: '')];
            } else {
              final splitTextSpans = <TextSpan>[];
              final index = originalText.indexOf(highlightedText);
              if (index == -1) {
                return [const TextSpan(text: '')];
              }
              final splitTexts = [
                originalText.substring(0, index),
                originalText.substring(index + highlightedText.length),
              ];

              if (splitTexts.length > 1) {
                splitTextSpans.add(TextSpan(text: localization.translate(splitTexts.first), style: textStyle));
                splitTextSpans.add(TextSpan(text: localization.translate(highlightedText), style: newTextStyle));
                splitTexts.removeAt(0);
              }

              originalText = splitTexts.last;

              return splitTextSpans;
            }
          })
          .toList()
          .expand((element) => element)
          .toList();

      highlighterTextSpans.add(TextSpan(text: localization.translate(originalText), style: textStyle));
      textSpans.addAll(highlighterTextSpans);
    }

    return textSpans;
  }

  String getMediumFontFamily() {
    final language = Localizations.localeOf(context).languageCode;
    return language == 'ar' ? 'NotoSans-mediumArabic' : 'NotoSans-medium';
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget({Key? key, required this.context, required this.attr}) : super(key: key);

  final BuildContext context;
  final PSPageHeaderTextUnderIconWidgetElementAttributes attr;

  @override
  Widget build(BuildContext context) {
    final Widget child;

    child = PSImage(
      PSImageModel(
        iconPath: attr.icon!,
        color: attr.iconColor ?? Theme.of(context).iconTheme.color,
        width: (attr.padding != null) ? attr.padding!.width : 0,
        height: (attr.padding != null) ? attr.padding!.height : 67,
      ),
    );

    if (attr.cornerRadius != null) {
      return ClipRRect(
        key: Key('PSPageHeaderTextUnderIconWidget_getIconClipRRect'),
        borderRadius: BorderRadius.all(Radius.circular(attr.cornerRadius!)),
        child: child,
      );
    }

    return child;
  }
}
