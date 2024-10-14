import 'dart:ui';

class DetailsWidgetAttributes {
  DetailsWidgetAttributes({
    required this.additionalDetailsRow,
    this.backgroundColor,
    this.isRTL = false,
    this.headerIconPath,
    this.title,
  });

  final List<RowData> additionalDetailsRow;
  Color? backgroundColor;
  bool? isRTL;
  String? headerIconPath;
  String? title;
}

class RowData {
  final String key;
  final String value;
  bool hasMultipleValues;
  List<String>? multipleValues;

  RowData({
    required this.key,
    required this.value,
    this.hasMultipleValues = false,
    this.multipleValues,
  });
}
