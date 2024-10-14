import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class CommonCTASecondaryAttributes {
  final String commonCTASecondaryButtonTitle;
  final VoidCallback commonCTASecondaryButtonOnPressed;
  CommonCTASecondaryAttributes({
    required this.commonCTASecondaryButtonTitle,
    required this.commonCTASecondaryButtonOnPressed,
  });
}

class _Constant {
  _Constant._();
  static const Color buttonBackgroundColor = Color(0xffFFFFFF);
  static const Color borderColor = Color(0xff000000);
  static const double borderWidth = 1.5;
  static const double borderRadius = 25;
  static const double zero = 0;
}

class CommonCTASecondary extends StatelessWidget {
  const CommonCTASecondary({
    Key? key,
    required this.attributes,
    this.buttonBackgroundColor = _Constant.buttonBackgroundColor,
    this.borderColor = _Constant.borderColor,
    this.borderWidth = _Constant.borderWidth,
    this.borderRadius = _Constant.borderRadius,
    this.textStyleVariant = PSTextStyleVariant.subtitle2,
  }) : super(key: key);

  final CommonCTASecondaryAttributes attributes;
  final Color buttonBackgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final PSTextStyleVariant textStyleVariant;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: attributes.commonCTASecondaryButtonOnPressed,
      style: ElevatedButton.styleFrom(
        elevation: _Constant.zero,
        backgroundColor: buttonBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      ),
      child: PSText(
        text: TextUIDataModel(
          attributes.commonCTASecondaryButtonTitle,
          styleVariant: textStyleVariant,
        ),
      ),
    );
  }
}
