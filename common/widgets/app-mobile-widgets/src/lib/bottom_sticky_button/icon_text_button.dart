import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _TitleDeedViewConstants {
  _TitleDeedViewConstants._();
  static const String downloadDeedIcon = 'user_journey:assets/icons/download_deed_icon.svg';
}

class IconTextButtonAttributes {
  final bool isRTL;
  final String iconButtonTitle;
  final VoidCallback iconButtonOnPressed;
  IconTextButtonAttributes({
    required this.isRTL,
    required this.iconButtonTitle,
    required this.iconButtonOnPressed,
  });
}

class _Constant {
  _Constant._();
  static const Color buttonBackgroundColor = Color(0xff000000);
  static const double iconHeight = 24;
  static const double iconWidth = 24;
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    required this.attributes,
    this.buttonBackgroundColor = _Constant.buttonBackgroundColor,
    this.iconHeight = _Constant.iconHeight,
    this.iconWidth = _Constant.iconWidth,
  }) : super(key: key);

  final IconTextButtonAttributes attributes;
  final Color buttonBackgroundColor;
  final double iconHeight;
  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: attributes.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: ElevatedButton.icon(
        onPressed: attributes.iconButtonOnPressed,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: buttonBackgroundColor,
        ),
        icon: PSImage(
          PSImageModel(
            height: iconHeight,
            width: iconWidth,
            iconPath: _TitleDeedViewConstants.downloadDeedIcon,
          ),
        ),
        label: PSText(
          text: TextUIDataModel(
            attributes.iconButtonTitle,
            styleVariant: PSTextStyleVariant.subtitle2,
          ),
        ),
      ),
    );
  }
}
