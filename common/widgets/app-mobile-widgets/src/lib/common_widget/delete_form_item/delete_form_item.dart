import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class DeleteFormItem extends StatelessWidget {
  final VoidCallback? onDelete;
  final String deleteText;

  const DeleteFormItem({
    Key? key,
    this.onDelete,
    this.deleteText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onDelete,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            PSText(
              text: TextUIDataModel(
                deleteText,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.delete_outline)
          ],
        ));
  }
}
