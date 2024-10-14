import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';


class _Constants {
  _Constants._();
  static const String commonImageLabel = 'open Map';
}
class CommonDetailsClickableImageWidgetAttributes {
  CommonDetailsClickableImageWidgetAttributes({
    this.openMap,
    required this.imagePath,
  });

  final VoidCallback? openMap;
  final String imagePath;
}

class CommonDetailsClickableImageWidget extends StatelessWidget {
  const CommonDetailsClickableImageWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonDetailsClickableImageWidgetAttributes attributes;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _Constants.commonImageLabel,
      focusable: true,
      child: GestureDetector(
        onTap: attributes.openMap,
        child: PSImage(
          PSImageModel(
            iconPath: attributes.imagePath,
          ),
        ),
      ),
    );
  }
}
