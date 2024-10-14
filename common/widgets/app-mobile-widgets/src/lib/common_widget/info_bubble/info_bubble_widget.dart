import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/info_bubble/info_bubble_attributes.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/padding.dart';

class InfoBubbleWidgetOverlayWrapper extends StatelessWidget {
  final String? title;
  final String? message;
  final String? iconLeftPath;
  final bool closeButton;
  const InfoBubbleWidgetOverlayWrapper({
    Key? key,
    required this.title,
    required this.message,
    this.iconLeftPath,
    this.closeButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final texts = <String>[
      if (title?.isNotEmpty ?? false) title!,
      if (message?.isNotEmpty ?? false) message!,
    ];

    var iconLeft = IconAttributes(
      iconName: iconLeftPath != null ? iconLeftPath! : 'app_mobile_login:assets/images/ic_info.svg',
      iconSizeWithPadding: PSPadding(
        width: 40,
        height: 40,
        top: 29,
        bottom: 29,
        left: 14,
        right: 14,
      ),
    );
    IconAttributes? closeIcon;
    if (closeButton) {
      closeIcon = IconAttributes(
        iconName: 'app_mobile_login:assets/images/ic_close.svg',
        onTap: () {
          OverlaySupportEntry.of(context)?.dismiss(animate: true);
        },
        iconSizeWithPadding: PSPadding(
          width: 31,
          height: 31,
          top: 30,
          bottom: 30,
          left: 14,
          right: 15,
        ),
      );
    }

    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: InfoBubbleWidget(
            attributes: InfoBubbleAttributes(
          backgroundColor: Theme.of(context).colorScheme.background,
          texts: texts,
          leadingIconAttributes: iconLeft,
          trailingIconAttributes: closeIcon,
        )),
      ),
    );
  }
}

class InfoBubbleWidget extends StatelessWidget {
  final InfoBubbleAttributes attributes;

  const InfoBubbleWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key('InfoBubbleWidget_Padding'),
      padding: EdgeInsets.only(
        top: attributes.bubblePadding.top,
        bottom: attributes.bubblePadding.bottom,
        left: attributes.bubblePadding.left,
        right: attributes.bubblePadding.right,
      ),
      child: Container(
        key: Key('InfoBubbleWidget_Container'),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
            color: attributes.backgroundColor),
        child: Row(
          key: Key('InfoBubbleWidget_Row'),
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (attributes.leadingIconAttributes != null) ...[
              Padding(
                key: Key('InfoBubbleWidget_AllSidedPadding'),
                padding: EdgeInsets.only(
                  top: attributes.leadingIconAttributes!.iconSizeWithPadding.top,
                  bottom: attributes.leadingIconAttributes!.iconSizeWithPadding.bottom,
                  left: attributes.leadingIconAttributes!.iconSizeWithPadding.left,
                  right: attributes.leadingIconAttributes!.iconSizeWithPadding.right,
                ),
                /* child: getSvg(
                  attributes.leadingIconAttributes!.iconName,
                  color: Theme.of(context).iconTheme.color,
                  width: attributes.leadingIconAttributes!.iconSizeWithPadding.width,
                ), */
                child: PSImage(
                  PSImageModel(
                    iconPath: attributes.leadingIconAttributes!.iconName,
                    color: Theme.of(context).iconTheme.color,
                    width: attributes
                        .leadingIconAttributes!.iconSizeWithPadding.width,
                  ),
                ),
              )
            ],
            Expanded(
              key: Key('InfoBubbleWidget_Expanded'),
              child: Column(
                key: Key('InfoBubbleWidget_ChildColumn'),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: attributes.texts
                    .map(
                      (element) => PSText(text: TextUIDataModel(element, styleVariant: PSTextStyleVariant.headline6)),
                    )
                    .toList(),
              ),
            ),
            if (attributes.trailingIconAttributes != null) ...[
              GestureDetector(
                onTap: () {
                  attributes.trailingIconAttributes!.onTap?.call();
                },
                child: Padding(
                  key: Key('InfoBubbleWidget_TrailingPadding'),
                  padding: EdgeInsets.only(
                    top: attributes.trailingIconAttributes!.iconSizeWithPadding.top,
                    bottom: attributes.trailingIconAttributes!.iconSizeWithPadding.bottom,
                    left: attributes.trailingIconAttributes!.iconSizeWithPadding.left,
                    right: attributes.trailingIconAttributes!.iconSizeWithPadding.right,
                  ),
                  /* child: getSvg(
                    attributes.trailingIconAttributes!.iconName,
                    color: Theme.of(context).iconTheme.color,
                    width: attributes.trailingIconAttributes!.iconSizeWithPadding.width,
                  ), */
                  child: PSImage(
                    PSImageModel(
                      iconPath: attributes.trailingIconAttributes!.iconName,
                      color: Theme.of(context).iconTheme.color,
                      width: attributes
                          .trailingIconAttributes!.iconSizeWithPadding.width,
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  //just for reference while its not integrated into project
  Widget exampleUsage(BuildContext context) {
    return InfoBubbleWidget(
      key: Key('InfoBubbleWidget_exampleUsageInfoBubbleWidget'),
      attributes: InfoBubbleAttributes(
        backgroundColor: Theme.of(context).colorScheme.background,
        texts: [
          'Upload failed:',
          'Max upload size is 25MB',
        ],
        leadingIconAttributes: IconAttributes(
          iconName: 'app_mobile_login:assets/images/ic_info.svg',
          // iconColor: theme.colorStyles.buttonColors.quaternary.normal.color,
          iconSizeWithPadding: PSPadding(
            width: 31,
            height: 31,
            top: 29,
            bottom: 29,
            left: 14,
            right: 14,
          ),
        ),
        trailingIconAttributes: IconAttributes(
          iconName: 'app_mobile_login:assets/images/ic_close.svg',
          // iconColor: theme.colorStyles.buttonColors.quaternary.normal.color,
          iconSizeWithPadding: PSPadding(
            width: 31,
            height: 31,
            top: 30,
            bottom: 30,
            left: 14,
            right: 15,
          ),
        ),
      ),
    );
  }
}
