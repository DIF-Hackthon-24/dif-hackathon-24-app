import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/transaction_list/transaction_menu_header.dart';
import 'package:widget_library/common_widget/transaction_list/transaction_section_header.dart';
import 'package:widget_library/common_widget/vertical_actionbar/ps_vertical_action_bar.dart';

import 'transaction_list_item.dart';

class TransactionListAttributes {
  final List<ActionModel> actions;
  final Map<DateTime, List<TransactionItemAttributes>>? groupedTransactions;
  final String yesterdayLocale;
  final String todayLocale;
  final String transactionTitleLocale;
  final bool showActions;
  final TextUIDataModel? emptyMessage;
  final Padding? emptyMessagePadding;
  TransactionListAttributes({
    required this.actions,
    this.groupedTransactions,
    required this.todayLocale,
    required this.yesterdayLocale,
    required this.transactionTitleLocale,
    this.showActions = true,
    this.emptyMessage,
    this.emptyMessagePadding,
  });
}

typedef TransactionItemBuilder = Widget Function(
  int sectionIndex,
  int index,
  TransactionItemAttributes attributes,
);

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactionListAttributes,
    this.transactionItemBuilder,
  }) : super(key: key);

  final TransactionListAttributes transactionListAttributes;
  final TransactionItemBuilder? transactionItemBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: false,
      children: [
        SliverPersistentHeader(
          key: Key('TransactionList_TransactionList_Header'),
          floating: false,
          pinned: true,
          delegate: TransactionMenuHeaderDelegate(
            actions: transactionListAttributes.actions,
            transactionTitleLocale: transactionListAttributes.transactionTitleLocale,
            showActions: transactionListAttributes.showActions,
          ),
        ),
        if (transactionListAttributes.groupedTransactions!.isEmpty && transactionListAttributes.emptyMessage != null)
          Padding(
            padding: transactionListAttributes.emptyMessagePadding!.padding,
            child: PSText(
              text: transactionListAttributes.emptyMessage!,
            ),
          ),
        ...List.generate(
          transactionListAttributes.groupedTransactions!.keys.length,
          (index) {
            return MultiSliver(
              pushPinnedChildren: true,
              children: [
                TransactionSectionHeader(
                  key: Key('TransactionList_TransactionSection_Header'),
                  transactionDate: transactionListAttributes.groupedTransactions!.keys.elementAt(index),
                  yesterdayLocale: transactionListAttributes.yesterdayLocale,
                  todayLocale: transactionListAttributes.todayLocale,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, traIndex) => GestureDetector(
                      onTap: () {
                        transactionListAttributes.groupedTransactions!.entries
                            .elementAt(index)
                            .value
                            .elementAt(traIndex)
                            .onItemTap!();
                      },
                      child: Builder(builder: (BuildContext context) {
                        var itemAttributes = transactionListAttributes.groupedTransactions!.entries
                            .elementAt(index)
                            .value
                            .elementAt(traIndex);
                        return (transactionItemBuilder != null)
                            ? transactionItemBuilder!(index, traIndex, itemAttributes)
                            : TransactionListItem(attributes: itemAttributes);
                      }),
                    ),
                    childCount: transactionListAttributes.groupedTransactions!.entries.elementAt(index).value.length,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
