import 'package:core/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/transaction_list/transaction_list_item_icon.dart';
import 'package:widget_library/common_widget/transaction_list/transaction_status_tag.dart';
import 'package:widget_library/padding.dart';

class TransactionItemAttributes {
  final TextUIDataModel amount;
  final String date;
  final String logoType;
  final String? transactionIconUrl;
  final TextUIDataModel? tagText;
  final TagColor? tagColor;
  final TextUIDataModel title;
  final TextUIDataModel? pretext;
  final TextUIDataModel? subtitle;
  final TextUIDataModel? withdrawer;
  final bool? completed;
  final Function()? onItemTap;

  TransactionItemAttributes({
    required this.amount,
    required this.date,
    required this.logoType,
    required this.title,
    this.completed,
    this.transactionIconUrl,
    this.tagText,
    this.tagColor,
    this.subtitle,
    this.pretext,
    this.withdrawer,
    this.onItemTap,
  });
}

class _Sizes {
  static const itemHeight = 80.0;
  static const titlePadding = PSPadding(left: 8, top: 20, width: 168);
  static const textSpace = 3.0;
}

class _TransactionOpacity {
  static const completed = 1.0;
  static const notCompleted = 0.7;
}

class TransactionListItem extends StatelessWidget {
  final String _transactionLogoType;
  final String? _transactionIconUrl;
  final TextUIDataModel _title;
  final TextUIDataModel? _subtitle;
  final TextUIDataModel _amount;
  final TextUIDataModel? _tagText;
  final TagColor? _tagColor;
  final bool _completed;

  TransactionListItem({Key? key, required TransactionItemAttributes attributes})
      : _transactionLogoType = attributes.logoType,
        _title = attributes.title,
        _subtitle = attributes.subtitle,
        _amount = attributes.amount,
        _transactionIconUrl = attributes.transactionIconUrl,
        _tagText = attributes.tagText,
        _tagColor = attributes.tagColor,
        _completed = attributes.completed ?? true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('TransactionList_Main_Container'),
      height: _Sizes.itemHeight,
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Constants.borderPadding,
          right: Constants.borderPadding,
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: _completed ? _TransactionOpacity.completed : _TransactionOpacity.notCompleted,
                  child: TransactionListItemIcon(
                    key: Key('TransactionList_TransactionItem_Icon'),
                    attributes: TransactionListItemIconAttributes(
                      iconLocalSrc: _transactionLogoType,
                      iconRemoteSrc: _transactionIconUrl,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: _Sizes.titlePadding.left,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: _completed ? _TransactionOpacity.completed : _TransactionOpacity.notCompleted,
                          child: Container(
                            width: _Sizes.titlePadding.width!,
                            child: PSText(
                              key: Key('TransactionList_TransactionItem_Title'),
                              text: TextUIDataModel(
                                _title.text,
                                maxLines: 2,
                                overflow: _title.overflow ?? TextOverflow.ellipsis,
                                styleVariant: _title.styleVariant ?? PSTextStyleVariant.transactionRowSubTitle,
                              ),
                            ),
                          ),
                        ),
                        if (_subtitle?.text.isNotEmptyOrNull ?? false)
                          Container(
                            padding: const EdgeInsets.only(top: _Sizes.textSpace),
                            width: _Sizes.titlePadding.width!,
                            child: Opacity(
                              opacity: _completed ? _TransactionOpacity.completed : _TransactionOpacity.notCompleted,
                              child: PSText(
                                key: Key('TransactionList_TransactionItem_Subtitle'),
                                text: TextUIDataModel(
                                  _subtitle!.text,
                                  maxLines: 1,
                                  styleVariant: _subtitle.styleVariant ??
                                      PSTextStyleVariant.transactionRowSubTitle,
                                  overflow: _subtitle.overflow ??
                                      TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        else if (_tagColor != null && _tagText != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: _Sizes.textSpace,
                            ),
                            child: TransactionStatusTag(
                              color: _tagColor,
                              text: _tagText,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: _completed ? _TransactionOpacity.completed : _TransactionOpacity.notCompleted,
                  child: PSText(
                    key: Key('TransactionList_TransactionItem_Amount'),
                    text: _completed
                        ? _amount
                        : _amount.copyWith(
                            styleVariant: PSTextStyleVariant.transactionRowAmountStrike,
                          ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 1,
              width: MediaQuery.of(context).size.width,
              child: Divider(
                key: Key('TransactionList_TransactionItem_Divider'),
                height: 1,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
