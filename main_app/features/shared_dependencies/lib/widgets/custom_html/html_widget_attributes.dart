class HtmlWidgetAttributes {
  bool isRtl;
  String htmlContent;
  Function(String url)? onLinkTap;

 HtmlWidgetAttributes({
    required this.isRtl,
    required this.htmlContent,
    this.onLinkTap,
  });
}