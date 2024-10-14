import 'package:core/translation/app_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

/// The data model to configure a [Text] widget
class PSTextDataModel {
  final TextUIDataModel? text;
  final String? iconPath;

  final EdgeInsets? padding;

  PSTextDataModel({
    required this.text,
    this.padding,
  }) : iconPath = null;

  /// Create a data model for icon details. Note that the colours and
  /// icon size are driven from the text styles
  PSTextDataModel.icon({
    required this.iconPath,
    this.padding,
  }) : text = null;
}

/// The data model to configure a [TextSpan] as part of the [PSTextRich] widget.
class PSTextSpanDataModel {
  /// A callback when the [TextSpan] is clicked
  VoidCallback? onPressed;

  PSTextDataModel psTextDataModel;

  /// The color used for links, defaults to the theme's color for button links.
  Color? linkColor;

  PSTextSpanDataModel(this.psTextDataModel, {this.onPressed, this.linkColor});
}

/// The data model to support [PSTextRich]
class PSTextRichDataModel {
  /// A list of models to render the [TextSpan] widgets
  List<PSTextSpanDataModel> textSpanDataModels;

  /// Any padding the widget requires.
  EdgeInsets? padding;

  PSTextRichDataModel({required this.textSpanDataModels, this.padding});
}

/// A wrapper around [Text.rich] that can be configured via
/// a [PSTextRichDataModel]. The spans support styles and callback links
class PSTextRich extends StatelessWidget {
  final PSTextRichDataModel model;
  PSTextRich(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key('PSTextRich_Padding'),
      padding: model.padding ?? const EdgeInsets.all(0),
      child: Text.rich(
        TextSpan(
          children: model.textSpanDataModels.map<InlineSpan>(
            (textSpanDataModel) {
              GestureRecognizer? recognizer;
              if (textSpanDataModel.onPressed != null) {
                recognizer = TapGestureRecognizer()..onTap = () => textSpanDataModel.onPressed?.call();
                // Links want to be same as button links, so override the color
              }
              if (textSpanDataModel.psTextDataModel.text != null) {
                return TextSpan(
                  text: AppLocalizations.of(context)!.translate(textSpanDataModel.psTextDataModel.text!.text),
                  style: buildTextStyle(
                    context: context,
                    variant: textSpanDataModel.psTextDataModel.text!.styleVariant ?? PSTextStyleVariant.normal,
                  ),
                  recognizer: recognizer,
                );
              }
              return WidgetSpan(
                /* child: getSvg(
                  textSpanDataModel.psTextDataModel.iconPath!,
                  color: Theme.of(context).iconTheme.color,
                  width: Theme.of(context).iconTheme.size,
                ), */
                child: PSImage(
                  PSImageModel(
                    iconPath: textSpanDataModel.psTextDataModel.iconPath!,
                    color: Theme.of(context).iconTheme.color,
                    width: Theme.of(context).iconTheme.size,
                  ),
                ),
              );
            },
          ).toList(),
        ),
        key: Key('PSTextRich_TextRich'),
      ),
    );
  }
}
