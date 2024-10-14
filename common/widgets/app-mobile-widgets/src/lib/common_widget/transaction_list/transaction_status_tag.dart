import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class TransactionStatusTag extends StatelessWidget {
  const TransactionStatusTag({
    Key? key,
    required TagColor color,
    required TextUIDataModel text,
  })  : _backgroundColor = color,
        _text = text,
        super(key: key);

  final TagColor _backgroundColor;
  final TextUIDataModel _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: _backgroundColor.value,
      ),
      child: PSText(
        text: _text,
      ),
    );
  }
}

enum TagColor {
  inProgress,
  pending,
  expired,
  cancelled,
  refund,
  declined,
  failed,
}

extension on TagColor {
  Color get value {
    switch (this) {
      case TagColor.inProgress:
      case TagColor.pending:
        return Color(0x33F9D100);
      case TagColor.expired:
      case TagColor.cancelled:
      case TagColor.declined:
      case TagColor.failed:
        return Color(0x33F90069);
      case TagColor.refund:
        return Color(0x3334ce97);
    }
  }
}
