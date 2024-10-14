import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/padding.dart';

class ListRowAttribute {
  ListRowAttribute({
    required this.dataModel,
    this.color,
    required this.backgroundImage,
    this.additionalDetailsRow,
    this.imageColor,
    this.isRTL = false,
    this.subAdditionalDetailsRow,
  });

  final ListRowDataModel dataModel;
  final String backgroundImage;
  final Color? color;
  final Color? imageColor;
  bool? isRTL;
  final List<ListRowDataModel>? additionalDetailsRow;
  final List<ListRowDataModel>? subAdditionalDetailsRow;
}

class ListRowDataModel {
  final String? imageUrl;
  final Color? iconBackgroundColor;
  final TextUIDataModel? subTitle;
  final TextUIDataModel title;
  final PSPadding titlePadding;
  void Function()? onTap;
  final PSPadding subtitlePadding;
  ListRowDataModel({
    required this.title,
    this.subTitle,
    this.imageUrl,
    this.iconBackgroundColor,
    this.onTap,
    this.titlePadding = const PSPadding.only(top: 11, bottom: 2),
    this.subtitlePadding = const PSPadding.only(bottom: 11),
  });
}
