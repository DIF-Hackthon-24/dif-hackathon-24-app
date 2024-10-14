import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonCTAAttributes {
  final String commonCTAButtonTitle;
  final VoidCallback commonCTAButtonOnPressed;
  final Key? key;
  CommonCTAAttributes({
    required this.commonCTAButtonTitle,
    required this.commonCTAButtonOnPressed,
    this.key,
  });
}

class _Constant {
  _Constant._();
  static const Color buttonBackgroundColor = Color(0xff000000);
}

class CommonCTA extends StatelessWidget {
  const CommonCTA({
    Key? key,
    required this.attributes,
    this.buttonBackgroundColor = _Constant.buttonBackgroundColor,
    this.textStyleVariant = PSTextStyleVariant.subtitle2,
  }) : super(key: key);

  final CommonCTAAttributes attributes;
  final Color buttonBackgroundColor;
  final PSTextStyleVariant textStyleVariant;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: attributes.key,
      onPressed: attributes.commonCTAButtonOnPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: buttonBackgroundColor,
      ),
      child: PSText(
        text: TextUIDataModel(
          attributes.commonCTAButtonTitle,
          styleVariant: textStyleVariant,
        ),
      ),
    );
  }
}
