import 'package:flutter/widgets.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'dart:io' show Platform;

enum MapTypes {
  google,
  apple,
  defaultMap,
}

class MapOptionsDailogContent {
  final String title;
  final String message;
  final String appleMap;
  final String googleMap;
  final String cancelCTA;

  MapOptionsDailogContent({
    required this.title,
    required this.message,
    required this.appleMap,
    required this.googleMap,
    required this.cancelCTA,
  });
}

class MapImageView extends StatelessWidget {
  const MapImageView({
    required this.iconPath,
    required this.openMap,
    required this.mapOptionsDailogContent,
    super.key,
  });
  final String iconPath;
  final MapOptionsDailogContent mapOptionsDailogContent;
  final Function(MapTypes) openMap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showOptionsToNavigateOnMap(context);
      },
      child: ExcludeSemantics(
        child: PSImage(
          PSImageModel(
            iconPath: iconPath,
            width:
                MediaQuery.of(context).size.width - 40,
          ),
        ),
      ),
    );
  }

  void showOptionsToNavigateOnMap(
    BuildContext context,
  ) async {
    if (Platform.isIOS) {
      final result = await showConfirmationDialog<MapTypes>(
        context: context,
        title: mapOptionsDailogContent.title,
        message: mapOptionsDailogContent.message,
        style: AdaptiveStyle.iOS,
        actions: [
          AlertDialogAction(
            key: MapTypes.apple,
            label: mapOptionsDailogContent.appleMap,
          ),
          AlertDialogAction(
            key: MapTypes.google,
            label: mapOptionsDailogContent.googleMap,
          ),
        ],
        cancelLabel: mapOptionsDailogContent.cancelCTA,
      );
      if (result != null) {
        if (result == MapTypes.google) {
          openMap(MapTypes.google);
        } else {
          openMap(MapTypes.defaultMap);
        }
      }
    } else {
      openMap(MapTypes.defaultMap);
    }
  }
}