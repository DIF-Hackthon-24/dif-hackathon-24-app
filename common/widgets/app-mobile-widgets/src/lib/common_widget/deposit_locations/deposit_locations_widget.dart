import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/buttons/cornered_icon_button.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_sheet_header_widget.dart';
import 'package:widget_library/common_widget/deposit_locations/deposit_locations_attributes.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/common_widget/transfers/beneficiary/item/ps_beneficiary_list_item_widget.dart';
import 'package:widget_library/common_widget/transfers/beneficiary/item/ps_beneficiary_list_item_widget_attributes.dart';
import 'package:widget_library/padding.dart';

class _Constants {
  static const sizeBoxHeightOne = 30.0;
  static const listItemLength = 0;
  static const radius = 10.0;
  static const borderRadius = 22.0;
  static const borderPadding = 32.0;
  static const backgroundColor = Colors.white;
  static const double height = 1.1;
  static const double depositVenueListContainerHeight = 50;
  static const String iconPath = 'widget_library:assets/images/ic_location.svg';
  static const double iconWidth = 55;
  static const double iconHeight = 55;
  static const double iconRadius = 10;
  static const double iconPadding = 20;
  static const double iconTopandBottomPadding = 10;
}

class DepositLocationsWidget extends StatelessWidget {
  final DepositLocationsAttributes attributes;

  DepositLocationsWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(_Constants.borderRadius);
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: EdgeInsets.only(
        top: _Constants.borderPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: radius,
        ),
        color: _Constants.backgroundColor,
      ),
      height: MediaQuery.of(context).size.height / _Constants.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: BottomSheetHeaderWidget(
              key: Key('ManageCardBottomSheetWidget_BottomSheetHeaderWidget'),
              cardHeaderData: attributes.depositLocationsCardHeaderText,
            ),
          ),
          _allDepositVenueList(context),
          SizedBox(
            height: _Constants.sizeBoxHeightOne,
          ),
          _allDepositLocationsListView(context),
        ],
      ),
    );
  }

  Widget _allDepositLocationsListView(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.vertical,
        children: [
          Divider(
            height: 1,
          ),
          ...List.generate(
            attributes.locations != null ? attributes.locations!.length : _Constants.listItemLength,
            (index) {
              return attributes.depositLocationVenueList.elementAt(attributes.venueLocationIndex ?? 0) ==
                      attributes.locations![index].region
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: PSBeneficiaryListItemWidget(
                            attributes: PSBeneficiaryListItemWidgetAttributes(
                              onTap: () {
                                attributes.onLocationSelect?.call(attributes.locations![index]);
                              },
                              title: TextUIDataModel(
                                attributes.locations![index].location ?? '',
                                styleVariant: PSTextStyleVariant.headline4,
                                textAlign: TextAlign.start,
                              ),
                              contentPadding: PSPadding(),
                              iconAttributes: PSBeneficiaryListItemIconAttributes(
                                type: PSBeneficiaryListIconType.cornered,
                                buttonType: ButtonType.icon,
                                path: _Constants.iconPath,
                                width: _Constants.iconWidth,
                                height: _Constants.iconHeight,
                                radius: _Constants.iconRadius,
                                buttonStyle: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    PSTheme().themeData.colorPalette?.panelColorPrimary.toColor() ?? Colors.white,
                                  ),
                                  foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _allDepositVenueList(BuildContext context) {
    return Container(
      height: _Constants.depositVenueListContainerHeight,
      child: ListView(
        padding: EdgeInsets.only(left: 30),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          ...List.generate(
            attributes.depositLocationVenueList.length,
            (index) => _depositVenueWidget(context, index),
          ),
        ],
      ),
    );
  }

  Widget _depositVenueWidget(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          attributes.venueListCallBack!(index);
        },
        child: Container(
          // height: _Constants.venueWidgetHeight,
          margin: EdgeInsets.only(
            left: 1,
          ),
          decoration: BoxDecoration(
            color: attributes.venueLocationIndex == index
                ? PSTheme().defaultTheme!.colorScheme.primary
                : PSTheme().defaultTheme!.highlightColor,
            borderRadius: BorderRadius.circular(_Constants.radius),
          ),
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: _Constants.iconPadding,
                  right: _Constants.iconPadding,
                  top: _Constants.iconTopandBottomPadding,
                  bottom: _Constants.iconTopandBottomPadding,
                ),
                child: PSText(
                  text: TextUIDataModel(
                    attributes.depositLocationVenueList.elementAt(index),
                    styleVariant: attributes.venueLocationIndex == index
                        ? PSTextStyleVariant.headline6
                        : PSTextStyleVariant.bodyText2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
