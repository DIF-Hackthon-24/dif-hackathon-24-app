import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/transaction_list/account_details_section_header_widget.dart';
import 'package:widget_library/common_widget/vertical_actionbar/ps_vertical_action_bar.dart';

class _Sizes {
  static const menuHeight = 100.0;
  static const shadowOffset = Offset(0, -2);
}

class TransactionMenuHeaderDelegate extends SliverPersistentHeaderDelegate {
  const TransactionMenuHeaderDelegate({
    required this.actions,
    required this.transactionTitleLocale,
    required this.showActions,
  });

  final List<ActionModel> actions;
  final String transactionTitleLocale;
  final bool showActions;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: _Sizes.menuHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.borderRadius),
          topRight: Radius.circular(Constants.borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: _Sizes.shadowOffset,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10.0),
      child: AccountDetailsSectionHeaderWidget(
        key: Key('TransactionSliverListView_AccountDetailsSectionHeaderWidget'),
        title: transactionTitleLocale,
        titleStyle: PSTextStyleVariant.headline4,
        actions: actions,
        showActions: showActions,
      ),
    );
  }

  @override
  double get maxExtent => _Sizes.menuHeight;

  @override
  double get minExtent => _Sizes.menuHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
