import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/transfers/beneficiary/item/ps_beneficiary_list_item_widget_attributes.dart';
import 'package:widget_library/padding.dart';

class PSBeneficiaryListWidgetAttributes {
  final PSPadding? padding;
  final TextUIDataModel? header;
  final List<PSBeneficiaryListItemWidgetAttributes> items;
  final Color? dividerColor;
  final double dividerThickness;
  final EdgeInsets dividerMargin;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  PSBeneficiaryListWidgetAttributes({
    this.padding,
    this.header,
    required this.items,
    this.dividerColor,
    this.dividerThickness = 1,
    this.dividerMargin = const EdgeInsets.all(0),
    this.scrollController,
    this.physics,
  });

  PSBeneficiaryListWidgetAttributes copyWith({
    final PSPadding? padding,
    final TextUIDataModel? header,
    required final List<PSBeneficiaryListItemWidgetAttributes> items,
    final Color? dividerColor,
    final double? dividerThickness,
    final EdgeInsets? dividerMargin,
    final ScrollController? scrollController,
    final ScrollPhysics? physics,
  }) =>
      PSBeneficiaryListWidgetAttributes(
        padding: padding ?? this.padding,
        header: header ?? this.header,
        items: items,
        dividerColor: dividerColor ?? this.dividerColor,
        dividerThickness: dividerThickness ?? this.dividerThickness,
        dividerMargin: dividerMargin ?? this.dividerMargin,
        scrollController: scrollController ?? this.scrollController,
        physics: physics ?? this.physics,
      );
}
