import 'dart:ui';

import 'package:widget_library/common_widget/square_panel_detail/square_panel_detail_attributes.dart';

class PSFile implements SquarePanelDetailAttributes {
  String key;
  String? path;
  DocSide docSide;

  PSFile({
    required this.key,
    this.path,
    this.docSide = DocSide.DEFAULT,
  }) : documentSide = docSide.toText;

  @override
  Color? backgroundColor;

  @override
  String? bottomText;

  @override
  Color? iconColor;

  @override
  String? iconPath;

  @override
  double? iconSize;

  @override
  String? subtitle;

  @override
  String? topExplainerText;

  @override
  String? topLeftText;

  @override
  String? topRightIconPath;

  @override
  String? uploadDocumentKey;

  @override
  String? filePath;

  @override
  late Function() onTap;

  @override
  String? documentSide;
}

enum DocSide {
  FRONT,
  BACK,
  DEFAULT,
}

extension DocSideInfo on DocSide {
  String get toText {
    switch (this) {
      case DocSide.FRONT:
        return DocumentSide.front;
      case DocSide.BACK:
        return DocumentSide.back;
      case DocSide.DEFAULT:
        return '';
    }
  }
}

class DocumentSide {
  static const front = 'front';
  static const back = 'back';
}
