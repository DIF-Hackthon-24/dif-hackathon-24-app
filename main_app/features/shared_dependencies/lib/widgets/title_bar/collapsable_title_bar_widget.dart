import 'package:core/media_query/ps_media_query.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class _Constants {
  static const backArrow = 'assets/images/arrow_left.svg';
  static const backRightArrow = 'assets/images/back_arrow_left.svg';
  static const themeName = 'new_applications';
}

class CollapsableTitleBarWidgetAttribute {
  final String title;
  final void Function() onBackArrowPressed;
  final bool isRtl;
  final String backButtonSemanticsLabel;

  CollapsableTitleBarWidgetAttribute({
    required this.title,
    required this.isRtl,
    this.onBackArrowPressed = goBack,
    required this.backButtonSemanticsLabel,
  });
}

void goBack() {
  NavigationManager.goBack();
}

class CollapsableTitleBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final CollapsableTitleBarWidgetAttribute attributes;

  const CollapsableTitleBarWidget({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safePadding = PSMediaQuery.padding.top;
    return Theme(
      data: PSTheme().themeFor(_Constants.themeName),
      child: Container(
        padding: EdgeInsets.only(
          top: safePadding + DimensionConstants.size14,
          left: attributes.isRtl
              ? DimensionConstants.size20
              : DimensionConstants.size10,
          right: attributes.isRtl
              ? DimensionConstants.size10
              : DimensionConstants.size20,
          bottom: DimensionConstants.size20,
        ),
        width: PSMediaQuery.screenWidth,
        color: PSTheme()
            .themeFor(_Constants.themeName)
            .appBarTheme
            .backgroundColor!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: attributes.onBackArrowPressed,
              child: Semantics(
                label: attributes.backButtonSemanticsLabel,
                focusable: true,
                child: PSImage(
                  PSImageModel(
                    iconPath: attributes.isRtl
                        ? _Constants.backArrow
                        : _Constants.backRightArrow,
                    height: DimensionConstants.size24,
                    width: DimensionConstants.size24,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: DimensionConstants.size15,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: attributes.isRtl
                    ? DimensionConstants.size0
                    : DimensionConstants.size6,
                right: attributes.isRtl
                    ? DimensionConstants.size6
                    : DimensionConstants.size0,
              ),
              child: PSText(
                text: TextUIDataModel(
                  attributes.title,
                  styleVariant: PSTextStyleVariant.headline1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DimensionConstants.size110);
}
