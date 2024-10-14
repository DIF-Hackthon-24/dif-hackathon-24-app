import 'package:flutter/material.dart';
import 'package:widget_library/map_image/map_image_view.dart';
import 'package:widget_library/common_details_section/common_details_list/common_details_bottom_text_widgets.dart';
import 'package:widget_library/common_details_section/common_details_list/common_details_list_tile.dart';
import 'package:widget_library/common_details_section/common_details_list/common_details_top_widget.dart';

class CommonDetailsListAttributes {
  final bool isRTL;
  final bool isTablet;
  final Function(MapTypes) openMap;
  final MapOptionsDailogContent mapOptionsDailogContent;
  final List? commonDetailTileTitleList;
  final List? commonDetailsTileValueList;
  final List? commonDetailsTileImagePathList;

  CommonDetailsListAttributes({
    required this.mapOptionsDailogContent,
    required this.openMap,
    this.isRTL = false,
    this.isTablet = false,
    this.commonDetailTileTitleList,
    this.commonDetailsTileValueList,
    this.commonDetailsTileImagePathList,
  });
}

class CommonDetailsList extends StatelessWidget {
  const CommonDetailsList({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonDetailsListAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getListOfcommonDetailCards(attributes),
    );
  }

  List<Widget> _getListOfcommonDetailCards(
    CommonDetailsListAttributes attributes,
  ) {
    final listCount = attributes.commonDetailTileTitleList != null
        ? attributes.commonDetailTileTitleList!.length
        : attributes.commonDetailsTileValueList!.length;
    return List<Widget>.generate(
      listCount,
      (index) {
        return CommonDetailsListTile(
          attributes: CommonDetailsListTileAttributes(
            isRTL: attributes.isRTL,
            isTablet: attributes.isTablet,
          ),
          commonDetailTileTitle: attributes.commonDetailTileTitleList != null &&
                  attributes.commonDetailTileTitleList![index] != null
              ? CommonDetailsTopWidget(
                  attributes: CommonDetailsTopWidgetAttributes(
                    detailsTitle: attributes.commonDetailTileTitleList![index] as String,
                  ),
                ) as Widget
              : null,
          commonDetailsTileValue: attributes.commonDetailsTileValueList != null &&
                  attributes.commonDetailsTileValueList![index] != null
              ? CommonDetailsBottomTextWidgets(
                  attributes: CommonDetailsBottomTextWidgetsAttributes(
                    detailsTextBottomValue:
                        attributes.commonDetailsTileValueList![index] as String,
                  ),
                ) as Widget
              : null,
          commonDetailsTileImage: attributes.commonDetailsTileImagePathList != null &&
                  attributes.commonDetailsTileImagePathList![index] != ''
              ? 
                MapImageView(
                        iconPath: attributes.commonDetailsTileImagePathList![index]
                      as String,
                        openMap: attributes.openMap,
                        mapOptionsDailogContent: attributes.mapOptionsDailogContent,
                      )
              : null,
        );
      },
    );
  }
}
