import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/square_panel_detail/square_panel_detail_attributes.dart';
import 'package:widget_library/common_widget/square_panel_detail/square_panel_detail_background_widget.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

import 'image_file_preview_widget.dart';

class SquarePanelDetailWidget extends StatelessWidget {
  final SquarePanelDetailAttributes attributes;
  final Function()? customOnTap;

  const SquarePanelDetailWidget({
    Key? key,
    required this.attributes,
    this.customOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        customOnTap != null ? customOnTap?.call() : attributes.onTap.call();
      },
      child: SquarePanelDetailBackgroundWidget(
        key: Key('SquarePanelDetailWidget_SquarePanelDetailBackgroundWidget'),
        color: attributes.backgroundColor ?? Theme.of(context).colorScheme.background,
        child: _getMainWidget(context),
      ),
    );
  }

  Widget _getMainWidget(BuildContext context) {
    return attributes.filePath != null
        ? getFullStateWidget(context, attributes.filePath!)
        : getEmptyStateWidget(context);
  }

  Widget getFullStateWidget(BuildContext context, String filePath) {
    return Padding(
      key: Key('SquarePanelDetailWidget_getFullStateWidget_Padding'),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Stack(
        key: Key('gSquarePanelDetailWidget_getFullStateWidget_Stack'),
        children: [
          Padding(
            key: Key('gSquarePanelDetailWidget_getFullStateWidget_Padding'),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24),
            child: Center(
              key: Key('gSquarePanelDetailWidget_getFullStateWidget_Center'),
              child: Material(
                key: Key('gSquarePanelDetailWidget_getFullStateWidget_Material'),
                elevation: 20,
                child: ImageFilePreviewWidget(
                    key: Key('gSquarePanelDetailWidget_getFullStateWidget_ImageFilePreviewWidget'), filePath: filePath),
              ),
            ),
          ),
          Positioned(
            key: Key('gSquarePanelDetailWidget_getFullStateWidget_Positioned'),
            top: 0,
            right: 0,
            left: 0,
            child: Row(
              key: Key('gSquarePanelDetailWidget_getFullStateWidget_Row'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PSText(
                  text: TextUIDataModel(
                    attributes.topLeftText ?? '',
                    styleVariant: PSTextStyleVariant.bodyText2,
                  ),
                  key: Key('gSquarePanelDetailWidget_getFullStateWidget_TopLeftText'),
                ),
                attributes.topRightIconPath != null
                    ? /* getSvg(
                        attributes.topRightIconPath!,
                        color: attributes.iconColor,
                      ) */
                    PSImage(
                        PSImageModel(
                          iconPath: attributes.topRightIconPath!,
                          color: attributes.iconColor,
                        ),
                      )
                    : Container(
                        key: Key('gSquarePanelDetailWidget_getFullStateWidget_NullContainer'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getEmptyStateWidget(BuildContext context) {
    return Column(
      key: Key('SquarePanelDetailWidget_getEmptyStateWidget_Column'),
      children: [
        SizedBox(key: Key('SquarePanelDetailWidget_getEmptyStateWidget_SizedBox'), height: 20),
        Expanded(
          child: Column(
            key: Key('SquarePanelDetailWidget_getEmptyStateWidget_ChildColumn'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(key: Key('SquarePanelDetailWidget_getEmptyStateWidget_ChildrenSizedBox'), height: 10),
              getIcon(context, attributes.iconPath),
              SizedBox(key: Key('SquarePanelDetailWidget_getEmptyStateWidget_AfterIconSizedBox'), height: 24),
              Container(
                key: Key('SquarePanelDetailWidget_getEmptyStateWidget_ChildrenContainer'),
                width: MediaQuery.of(context).size.width * .6,
                child: Text(attributes.subtitle ?? '',
                    key: Key('SquarePanelDetailWidget_getEmptyStateWidget_SubtitleText'), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
        Container(
          key: Key('SquarePanelDetailWidget_getEmptyStateWidget_BottomTextContainer'),
          width: MediaQuery.of(context).size.width * .6,
          child: Text(
            attributes.bottomText ?? '',
            key: Key('SquarePanelDetailWidget_getEmptyStateWidget_BottomText'),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(key: Key('SquarePanelDetailWidget_getEmptyStateWidget_HeightSizedBox'), height: 40),
      ],
    );
  }

  Widget getIcon(BuildContext context, String? iconPath) {
    if (iconPath == null) return Container(key: Key('NullContainer'));
    /* return getSvg(
      attributes.iconPath!,
      width: attributes.iconSize ?? 62,
    ); */
    return PSImage(
      PSImageModel(
        iconPath: attributes.iconPath!,
        width: attributes.iconSize ?? 62,
      ),
    );
  }
}
