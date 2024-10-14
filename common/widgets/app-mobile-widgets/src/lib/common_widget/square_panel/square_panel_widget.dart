import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/chip/chip_widget.dart';
import 'package:widget_library/common_widget/chip/chip_widget_attributes.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/square_panel/ps_file.dart';
import 'package:widget_library/common_widget/square_panel/square_panel_attributes.dart';
import 'package:widget_library/common_widget/square_panel/square_panel_theme_attributes.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
// import 'package:widget_library/common_widget/utils/icon_utils.dart';

class SquarePanelWidget extends StatelessWidget {
  final SquarePanelAttributes attributes;
  final Function(SquarePanelAttributes)? customOnTap;

  final double width = 149.0;
  final double height = 136.0;
  final double defaultRadius = 10;
  final String defaultTopRightIcon = 'app_mobile_login:assets/images/ic_info.svg';

  const SquarePanelWidget({Key? key, required this.attributes, this.customOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemTheme = _getTheme(context, attributes.isSelected);
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius),
      onTap: () {
        customOnTap != null ? customOnTap?.call(attributes) : attributes.onTap?.call(attributes);
      },
      child: AspectRatio(
        key: Key('SquarePanelWidget_AspectRatio'),
        aspectRatio: width / height,
        child: Container(
          width: width,
          height: height,
          key: Key('SquarePanelWidget_Container'),
          decoration: BoxDecoration(
            color: itemTheme.backgroundColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Padding(
            key: Key('SquarePanelWidget_Padding'),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: Key('SquarePanelWidget_ChildColumn'),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    getTitleWidget(itemTheme),
                    if (attributes.topRightChipLabel != null) ...[
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      ChipWidget(
                        key: Key('SquarePanelWidget_optionalWidget_Container'),
                        attributes: ChipWidgetAttributes(
                          label: attributes.topRightChipLabel!,
                          backgroundColor: Theme.of(context).splashColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4),
                getSubtitleWidget(context, itemTheme),
                Spacer(key: Key('SquarePanelWidget_ChildSpacer')),
                Row(
                  key: Key('SquarePanelWidget_Row'),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    getBottomLeftWidget(itemTheme, context),
                    Spacer(key: Key('SquarePanelWidget_BottomSpacer')),
                    getBottomRightWidget(itemTheme),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitleWidget(SquareThemeAttributes theme) {
    return Container(
      key: Key('SquarePanelWidget_getTitleWidget_Container'),
      child: Flexible(
        fit: FlexFit.tight,
        child: Text(
          attributes.title,
          textAlign: TextAlign.start,
          style: theme.titleStyle,
        ),
      ),
    );
  }

  Widget getBottomRightWidget(SquareThemeAttributes theme) {
    if (attributes.onInfoTap == null) return Container();
    return InkWell(
      key: Key('SquarePanelWidget_getBottomRightWidget_InkWell'),
      borderRadius: BorderRadius.circular(defaultRadius),
      onTap: () => attributes.onInfoTap?.call(attributes),
      //child: getSvg(attributes.infoIconPath ?? defaultTopRightIcon, color: theme.topRightIconColor),
      child: PSImage(
        PSImageModel(
          iconPath: attributes.infoIconPath ?? defaultTopRightIcon,
          color: theme.topRightIconColor,
        ),
      ),
    );
  }

  Widget getBottomLeftWidget(SquareThemeAttributes theme, BuildContext context) {
    if (attributes.streamProgress != null && _allSidesUploaded()) {
      final size = width * 0.15;
      return getProgress(size, theme, progressCompletedWidget(context));
    }
    //return getSvg(attributes.uploadIconPath, color: theme.bottomLeftIconColor);
    return PSImage(
      PSImageModel(
        iconPath: attributes.uploadIconPath,
        color: theme.bottomLeftIconColor,
      ),
    );
  }

  bool _allSidesUploaded() {
    final nonDefaultSidedDocumentsCount = attributes.children
        .where((element) => (element as PSFile).docSide != DocSide.DEFAULT && element.filePath != null)
        .toList()
        .length;
    return nonDefaultSidedDocumentsCount != 1;
  }

  Widget getSubtitleWidget(BuildContext context, SquareThemeAttributes theme) {
    return attributes.subtitle.isNotEmpty
        ? PSText(
            text: TextUIDataModel(attributes.subtitle, styleVariant: PSTextStyleVariant.hints),
            key: Key('getTopLeftWidgetLabelText'),
          )
        : SizedBox();
  }

  Widget progressCompletedWidget(BuildContext context) {
    return ChipWidget(
        key: Key('SquarePanelWidget_progressCompletedWidget_Container'),
        attributes: ChipWidgetAttributes(
          label: attributes.progressCompletedLabel,
          backgroundColor: Theme.of(context).splashColor,
        ));
  }

  Widget getProgress(double size, SquareThemeAttributes theme, Widget child) {
    return StreamBuilder<double>(
      key: Key('SquarePanelWidget_getProgress_StreamBuilder'),
      stream: attributes.streamProgress,
      builder: (context, AsyncSnapshot<double> snapshot) {
        if (snapshot.data != null && snapshot.data! >= 1) return child;
        return SizedBox(
          key: Key('SquarePanelWidget_getProgress_ReturnSizedBox'),
          height: size,
          width: size,
          child: CircularProgressIndicator(
            key: Key('SquarePanelWidget_getProgress_CircularProgressIndicator'),
            value: snapshot.data,
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(theme.topRightIconColor),
            backgroundColor: theme.progressBackgroundColor,
          ),
        );
      },
    );
  }

  SquareThemeAttributes _getTheme(BuildContext context, bool isSelected) {
    return isSelected ? getDarkTheme(context) : getLightTheme(context);
  }

  SquareThemeAttributes getDarkTheme(BuildContext context) {
    return SquareThemeAttributes(
      topRightIconColor: Theme.of(context).textTheme.bodyLarge!.color!,
      //bottomLeftIconColor: Theme.of(context).accentIconTheme.color ?? Theme.of(context).accentColor,
      bottomLeftIconColor: Theme.of(context).primaryColorDark,
      titleStyle: Theme.of(context).textTheme.bodyLarge!,
      backgroundColor: Theme.of(context).primaryColorDark,
      progressBackgroundColor: PSTheme().themeData.colorPalette!.infoIcon.toColor(),
    );
  }

  SquareThemeAttributes getLightTheme(BuildContext context) {
    return SquareThemeAttributes(
      topRightIconColor: PSTheme().themeData.colorPalette!.infoIcon.toColor(),
      bottomLeftIconColor: Theme.of(context).colorScheme.primary,
      titleStyle: Theme.of(context).textTheme.bodyMedium!,
      backgroundColor: Theme.of(context).primaryColorLight,
      progressBackgroundColor: Theme.of(context).textTheme.bodyLarge!.color!,
    );
  }
}
