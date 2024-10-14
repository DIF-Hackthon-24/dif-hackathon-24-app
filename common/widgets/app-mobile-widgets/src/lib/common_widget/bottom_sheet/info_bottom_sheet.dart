import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/docked_button.dart';
import 'package:widget_library/common_widget/constants.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _Constants {
  _Constants._();

  static const double mainPadding = 20;
  static const double closeIconSize = 30;
  static const String pictosIconPath = 'widget_library:assets/images/ic_pictos.svg';
}

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({
    required this.title,
    required this.description,
    required this.textButtonTitle,
    required this.onTextButtonPressed,
    required this.primaryButtonTitle,
    required this.onPrimaryButtonPressed,
    this.height,
    this.backgroundColor,
    Key? key,
  });

  final String title;
  final String description;
  final String textButtonTitle;
  final VoidCallback onTextButtonPressed;
  final String primaryButtonTitle;
  final VoidCallback onPrimaryButtonPressed;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_Constants.mainPadding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kTopCornerRadiusBottomSheet),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(alignment: Alignment.centerRight, child: _CrossButton()),
          const Align(alignment: Alignment.centerLeft, child: _InfoIcon()),
          const SizedBox(height: 20),
          Align(alignment: Alignment.centerLeft, child: _Title(title: title)),
          const SizedBox(height: 8),
          _Description(description: description),
          const SizedBox(height: 8),
          _TextButton(title: textButtonTitle, onPressed: onTextButtonPressed),
          const SizedBox(height: 8),
          _PrimaryButton(title: primaryButtonTitle, onPressed: onPrimaryButtonPressed),
        ],
      ),
    );
  }
}

class _CrossButton extends StatelessWidget {
  const _CrossButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.close,
        size: _Constants.closeIconSize,
      ),
    );
  }
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PSImage(PSImageModel(iconPath: _Constants.pictosIconPath));
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        title,
        styleVariant: PSTextStyleVariant.headline2,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.description, Key? key}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return PSText(
      text: TextUIDataModel(
        description,
        styleVariant: PSTextStyleVariant.bodyText2,
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(85, 0, 249, 1),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      child: Text(title),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PSDockedButton(
      title: title,
      onPressed: onPressed,
    );
  }
}
