import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:shared_dependencies/widgets/additional_app_details/details_widget_attributes.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class _Constants {
  static const themeName = 'consent_details';
}

class DetailsWidget extends StatelessWidget {
  final DetailsWidgetAttributes attributes;

  const DetailsWidget({required this.attributes, super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: PSTheme().themeFor(_Constants.themeName),
      child: Container(
        color: attributes.backgroundColor?? ColorConstants.COLOR_FFF9F8F7,
        padding: EdgeInsets.only(
          top: DimensionConstants.size30,
          bottom: DimensionConstants.size40,
        ),
        child: Column(
          children: [
            Row(
              children: [
                PSImage(
                  PSImageModel(
                    iconPath: attributes.headerIconPath ?? '',
                    width: DimensionConstants.size24,
                    height: DimensionConstants.size24,
                    color: ColorConstants.COLOR_FF505152,
                  ),
                ),
                const SizedBox(
                  width: DimensionConstants.size8,
                ),
                PSText(
                  text: TextUIDataModel(
                    attributes.title ?? '',
                    styleVariant: PSTextStyleVariant.headline3,
                  ),
                ),
                const SizedBox(
                  height: DimensionConstants.size12,
                ),
              ],
            ),
            const SizedBox(
              height: DimensionConstants.size12,
            ),
            Column(
              children: attributes.additionalDetailsRow
                  .map((e) => Padding(
                        padding: EdgeInsets.symmetric(vertical: DimensionConstants.size5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: PSText(
                                text: TextUIDataModel(
                                  e.key,
                                  styleVariant: PSTextStyleVariant.headline4,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            e.hasMultipleValues
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end ,
                                    children: e.multipleValues!
                                        .map((element) => PSText(
                                          text: TextUIDataModel(
                                            element,
                                            styleVariant: PSTextStyleVariant.headline5,
                                            textAlign: TextAlign.end,
                                          ),
                                        ))
                                        .toList(),
                                  ))
                                : Expanded(
                                    child: PSText(
                                      text: TextUIDataModel(
                                        e.value,
                                        styleVariant: PSTextStyleVariant.headline5,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
