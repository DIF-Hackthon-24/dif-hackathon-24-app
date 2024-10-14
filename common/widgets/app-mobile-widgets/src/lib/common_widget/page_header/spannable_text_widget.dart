import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

/// Widget that combines texts with different text styles
class SpannedTextWidget extends StatelessWidget {
  final List<TextUIDataModel> texts;
  final TextAlign? textAlign;

  const SpannedTextWidget({
    Key? key,
    required this.texts,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(
          children: [
            ...texts.map(
              (text) => PSTextSpan(
                context: context,
                text: text,
              ),
            ),
          ],
        ),
      );
}
