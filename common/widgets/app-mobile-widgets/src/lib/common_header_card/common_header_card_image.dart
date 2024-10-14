import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';

class CommonHeaderCardImageAttributes {
  final String headerImagePath;
  CommonHeaderCardImageAttributes({
    required this.headerImagePath,
  });
}

class CommonHeaderCardImage extends StatelessWidget {
  const CommonHeaderCardImage({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonHeaderCardImageAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return PSImage(
      PSImageModel(
        iconPath: attributes.headerImagePath,
      ),
    );
  }
}
