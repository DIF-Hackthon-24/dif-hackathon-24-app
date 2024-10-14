import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:shared_dependencies/widgets/custom_html/html_widget_attributes.dart';

class _Constants{
  static const lineHeightArabic = 1.25;
  static const lineHeightEnglish = 1.00;
}
class FaqHtmlWidget extends StatelessWidget {
  final HtmlWidgetAttributes attributes;
  const FaqHtmlWidget({required this.attributes, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Html(data: attributes.htmlContent,
    onLinkTap: (url, attr, element){
      attributes.onLinkTap?.call(url ?? '');
    },
    style: {
      '*': Style(
        margin: Margins.only(top: DimensionConstants.size0),
        lineHeight: attributes.isRtl? LineHeight.em(_Constants.lineHeightArabic) : LineHeight.em(_Constants.lineHeightEnglish),
        fontSize: FontSize(DimensionConstants.size16),
        fontFamily: attributes.isRtl? 'NotoSansArabic': 'NotoSans',
        fontWeight: FontWeight.w400,
        color: ColorConstants.COLOR_FF0F1A38
      ),
      'a': Style(
        color: ColorConstants.COLOR_FF457197,
        textDecoration: TextDecoration.underline,
      ),
      'ul,ol': Style(
        margin: Margins.only(
          left: attributes.isRtl? DimensionConstants.size0: DimensionConstants.size20, 
          right: attributes.isRtl? DimensionConstants.size20: DimensionConstants.size0
        ),
        padding: HtmlPaddings.zero,
      )
    },
    );
  }
}