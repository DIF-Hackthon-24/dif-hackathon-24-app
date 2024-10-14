import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

enum CommonIconBottomSheet {
  warningIcon,
}

class _Constants {
  static const minHeightBottomSheet = 200.0;
  static const iconSize = 64.0;
  static const twentyFour = 24.0;
  static const double zeroPixels = 0.0;
  static const double twenty = 20;
  static const double sixteen = 16;
  static const double eight = 8;
  static const double four = 4;
  static const double fourty = 40;
  static const Color lightGrayColor = Color(0xffC7C7C7);
  static const Color darkGrayColor = Color(0xff7A7C7C);
  static const String iconPath = 'assets/icons/round_bell_icon.svg';
  static const String iconCrossPath = 'assets/icons/ic_cross.svg';
  static const String iconOpenURLPath = 'assets/icons/open_url_icon.svg';
  static const String iconGreenTickPath =
      'dashboard:assets/icons/green_tick_icon.svg';
  static const double fourteen = 14;
  static const clickableColor = Color(0xFF457197);

}

class BeforeStartBottomSheetAttributes {
  BeforeStartBottomSheetAttributes({
    required this.isRTL,
    required this.title,
    required this.theme,
    required this.iconPath,
    required this.onItemPress,
    required this.configDetailsModelList,
    required this.backButtonPressed,
  });

  final bool isRTL;
  final String title;
  final String theme;
  final String iconPath;
  final List<ConfigDetailsModel> configDetailsModelList;
  final Function(String) onItemPress;
  final VoidCallback backButtonPressed;
}

class ConfigDetailsModel {
  ConfigDetailsModel({
    required this.title,
    required this.key,
  });

  final String title;
  final String key;
}

class BeforeStartBottomSheetView extends StatefulWidget {
  const BeforeStartBottomSheetView({
    required this.attributes,
    Key? key,
  }) : super(key: key);

  final BeforeStartBottomSheetAttributes attributes;

  @override
  State<BeforeStartBottomSheetView> createState() =>
      _BeforeStartBottomSheetViewState();
}

class _BeforeStartBottomSheetViewState
    extends State<BeforeStartBottomSheetView> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: PSTheme().themeFor(widget.attributes.theme),
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: _Constants.zeroPixels,
              left: _Constants.zeroPixels,
              right: _Constants.zeroPixels,
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: _Constants.minHeightBottomSheet,
                ),
                padding: EdgeInsets.symmetric(horizontal: _Constants.twenty),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_Constants.twenty),
                    topRight: Radius.circular(_Constants.twenty),
                  ),
                  color: Colors.white,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _renderRectangleView(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: _Constants.sixteen),
                        child: _renderIcons(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: PSText(
                          text: TextUIDataModel(
                            widget.attributes.title,
                            styleVariant: PSTextStyleVariant.headline1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _Constants.twentyFour,
                      ),
                      _listViewBuilder(),
                      SizedBox(
                        height: _Constants.twentyFour,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderRectangleView() {
    return Padding(
      padding: EdgeInsets.only(
        top: _Constants.eight,
      ),
      child: Container(
        height: _Constants.four,
        width: _Constants.fourty,
        decoration: BoxDecoration(
          color: _Constants.lightGrayColor,
          borderRadius: BorderRadius.all(Radius.circular(_Constants.four / 2)),
        ),
      ),
    );
  }

  Widget _renderIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _Constants.iconSize,
          width: _Constants.iconSize,
          child: PSImage(
            PSImageModel(
              iconPath: _Constants.iconPath,
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: widget.attributes.backButtonPressed,
          child: Container(
            height: _Constants.twentyFour,
            width: _Constants.twentyFour,
            padding: EdgeInsets.all(_Constants.four),
            child: PSImage(
              PSImageModel(
                iconPath: _Constants.iconCrossPath,
                color: _Constants.darkGrayColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listViewBuilder() {
    return Column(
      children: widget.attributes.configDetailsModelList
          .map((e) => _ConfigListItem(e))
          .toList(),
    );
  }

  Widget _ConfigListItem(ConfigDetailsModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: _Constants.sixteen,
            bottom: _Constants.sixteen,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.attributes.onItemPress(item.key),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _renderText(item.title),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: _Constants.twentyFour),
                child: PSImage(
                  PSImageModel(
                    height: _Constants.twenty,
                    width: _Constants.twenty,
                    iconPath: _Constants.iconGreenTickPath,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: _Constants.lightGrayColor,
        ),
      ],
    );
  }

  Widget _renderText(String title) {
    final language = Localizations.localeOf(context).languageCode;
    final fontFamily = language == 'ar' ? 'NotoSansArabic' : 'NotoSans';

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title.split('<U>').first,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: _Constants.fourteen,
            ),
          ),
          TextSpan(
            text: title.split('<U>').last.split('</U>').first,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: _Constants.fourteen,
              color: _Constants.clickableColor,
            ),
          ),
          TextSpan(
            text: title.split('<U>').last.split('</U>').last,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: _Constants.fourteen,
            ),
          ),
          TextSpan(
            text: '  ',
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: _Constants.fourteen,
            ),
          ),
          WidgetSpan(
            child: PSImage(
              PSImageModel(
                iconPath: _Constants.iconOpenURLPath,
                color: _Constants.clickableColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
