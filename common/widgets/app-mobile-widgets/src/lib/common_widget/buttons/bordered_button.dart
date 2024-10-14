import 'package:core/translation/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';

class BorderedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? foreGroundColor;
  final EdgeInsets padding;
  final String? leadingIcon;
  final String? trailingIcon;
  final Radius borderRadius;

  BorderedButton({
    this.title = '',
    this.foreGroundColor,
    this.onTap,
    this.padding = const EdgeInsets.all(8.0),
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius = const Radius.circular(5),
  });

  @override
  Widget build(BuildContext context) {
    final color = foreGroundColor ?? Theme.of(context).primaryColor;

    return InkWell(
      key: Key('BorderedButton_InkWell'),
      onTap: onTap,
      child: Container(
        key: Key('BorderedButton_Container'),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.all(borderRadius),
        ),
        child: Padding(
          key: Key('BorderedButton_Padding'),
          padding: padding,
          child: Row(
            key: Key('BorderedButton_Row'),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null)
                Expanded(
                  flex: 2,
                  child: Center(
                    key: Key('BorderedButton_Icon_Leading'),
                    /* child: getSvg(
                      leadingIcon!,
                    ), */
                    child: PSImage(
                      PSImageModel(
                        iconPath: leadingIcon!,
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 8,
                child: Text(
                  AppLocalizations.of(context)!.translate(title),
                  key: Key('BorderedButton_Text'),
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    height: 18 / 14,
                    fontFamily: 'AktivGrotesqueRg',
                  ),
                ),
              ),
              if (trailingIcon != null)
                Expanded(
                  flex: 2,
                  child: Center(
                    key: Key('BorderedButton_Icon_Trailing'),
                    /* child: getSvg(
                      trailingIcon!,
                    ), */
                    child: PSImage(
                      PSImageModel(
                        iconPath: trailingIcon!,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
