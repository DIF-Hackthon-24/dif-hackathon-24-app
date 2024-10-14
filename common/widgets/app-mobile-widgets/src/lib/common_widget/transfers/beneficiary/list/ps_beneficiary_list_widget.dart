import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/transfers/beneficiary/item/ps_beneficiary_list_item_widget.dart';
import 'package:widget_library/common_widget/transfers/beneficiary/item/ps_beneficiary_list_item_widget_attributes.dart';

import 'ps_beneificary_list_widget_attributes.dart';

class _Constants {
  static const headerTopPadding = 16.0;
  static const headerStartPadding = 16.0;
}

class PSBeneficiaryListWidget extends StatelessWidget {
  final PSBeneficiaryListWidgetAttributes attributes;
  final List<int> headerIndexes = [];
  final SlidableController? slidableController;
  final PSBeneficiaryListScreenType? screenType;

  PSBeneficiaryListWidget({
    Key? key,
    required this.attributes,
    this.slidableController,
    this.screenType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  Widget _buildListView() {
    return ListView.separated(
      key: Key('PSBeneficiaryListWidget_ListView'),
      physics: attributes.physics,
      shrinkWrap: true,
      itemCount: _listViewCount(),
      controller: _listViewCount() > 2 ? attributes.scrollController : null,
      padding: (attributes.padding != null)
          ? EdgeInsets.fromLTRB(
              attributes.padding!.left,
              attributes.padding!.top,
              attributes.padding!.right,
              attributes.padding!.bottom,
            )
          : EdgeInsets.zero,
      itemBuilder: (context, index) {
        return _buildLineItem(
          attributes.items[index],
          index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return headerIndexes.contains(index)
            ? Container(
                key: Key('PSBeneficiaryListWidget_Container'),
              )
            : Container(
                key: Key('PSBeneficiaryListWidget_DividerContainer'),
                margin: attributes.dividerMargin,
                child: Divider(
                  key: Key('PSBeneficiaryListWidget_Divider'),
                  thickness: attributes.dividerThickness,
                ),
              );
      },
    );
  }

  int _listViewCount() {
    var length = attributes.items.length;
    if (attributes.header != null) {
      length += 1;
    }

    return length;
  }

  Widget _buildLineItem(PSBeneficiaryListItemWidgetAttributes item, int index) {
    switch (item.type) {
      case PSBeneficiaryListItemWidgetType.lineItem:
        return PSBeneficiaryListItemWidget(
          key: Key('PSBeneficiaryListWidget_PSBeneficiaryListItemWidget'),
          attributes: item,
          slidableController: slidableController,
          screenType: screenType,
        );

      case PSBeneficiaryListItemWidgetType.header:
        headerIndexes.add(index);
        return _buildBeneficiaryListItemHeader(item.title);
    }
  }

  Widget _buildBeneficiaryListItemHeader(TextUIDataModel title) {
    return Padding(
      key: Key('PSBeneficiaryListWidget_Header'),
      padding: const EdgeInsetsDirectional.only(
        start: _Constants.headerStartPadding,
        top: _Constants.headerTopPadding,
      ),
      child: PSText(text: title),
    );
  }
}
