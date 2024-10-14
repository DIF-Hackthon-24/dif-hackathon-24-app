import 'package:core/translation/app_localization.dart';
import 'package:core/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _Constants {
  static const headerHeight = 40.0;
  static const defaultDateFormat = 'dd MMM yyyy';
}

class TransactionSectionHeader extends StatelessWidget {
  const TransactionSectionHeader({
    Key? key,
    required this.transactionDate,
    required this.yesterdayLocale,
    required this.todayLocale,
  }) : super(key: key);

  final DateTime transactionDate;
  final String yesterdayLocale;
  final String todayLocale;

  @override
  Widget build(BuildContext context) {
    final title = transactionDate.isYesterday()
        ? AppLocalizations.of(context)!.translate('$yesterdayLocale')
        : transactionDate.isToday()
            ? AppLocalizations.of(context)!.translate('$todayLocale')
            : transactionDate.toFormattedDate('${_Constants.defaultDateFormat}',false);

    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: _SectionHeaderDelegate(title: title),
    );
  }
}

class _SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  // final Color? backgroundColor;
  final String title;

  _SectionHeaderDelegate({
    // this.backgroundColor,
    required this.title,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      padding: const EdgeInsets.symmetric(horizontal: Constants.borderPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 4),
          PSText(
            text: TextUIDataModel(title.toUpperCase(), styleVariant: PSTextStyleVariant.sectionHeader),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _Constants.headerHeight;

  @override
  double get minExtent => _Constants.headerHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
