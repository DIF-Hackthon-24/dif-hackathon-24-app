import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class TransactionListItemIconAttributes {
  final String iconLocalSrc;
  final String? title;
  final String? iconRemoteSrc;
  final Color iconBackgroundColor;
  final Color miniIconBackgroundColor;
  final Color miniIconColor;

  TransactionListItemIconAttributes({
    required this.iconLocalSrc,
    this.iconBackgroundColor = const Color(0xFFEFF0F2),
    this.title,
    this.iconRemoteSrc,
    this.miniIconBackgroundColor = const Color(0xffDFE0E4),
    this.miniIconColor = const Color(0xff0F1A38),
  });
}

class TransactionListItemIcon extends StatelessWidget {
  final TransactionListItemIconAttributes _attributes;

  const TransactionListItemIcon({
    Key? key,
    required TransactionListItemIconAttributes attributes,
  })  : _attributes = attributes,
        super(key: key);

  static const double _iconSize = 40;
  static const double _totalSize = 46;
  static const double _miniIconSize = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _totalSize,
      width: _totalSize,
      margin: EdgeInsets.only(top: _totalSize - _iconSize),
      child: Stack(
        children: [
          Container(
            width: _iconSize,
            height: _iconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _attributes.iconBackgroundColor,
            ),
            child: _buildIcon(),
          ),
          if (showMiniIcon())
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: _miniIconSize,
                height: _miniIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _attributes.miniIconBackgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: PSImage(PSImageModel(
                    iconPath: _attributes.iconLocalSrc,
                    color: _attributes.miniIconColor,
                    boxFit: BoxFit.scaleDown,
                  )),
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool showMiniIcon() => _attributes.iconRemoteSrc != null || _attributes.title != null;

  Widget _buildIcon() {
    if (_attributes.iconRemoteSrc != null) {
      return CircleAvatar(
        radius: _iconSize,
        backgroundImage: NetworkImage(_attributes.iconRemoteSrc!),
        backgroundColor: _attributes.iconBackgroundColor,
      );
    } else if (_attributes.title != null) {
      return Center(
        child: PSText(
          text: TextUIDataModel(
            _createShortTitle(_attributes.title!),
            styleVariant: PSTextStyleVariant.iconTitle,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: PSImage(PSImageModel(
          iconPath: _attributes.iconLocalSrc,
          boxFit: BoxFit.scaleDown,
        )),
      ); // fallback
    }
  }

  String _createShortTitle(String title) {
    final words = title.split(' ');
    if (words.isEmpty) return '';
    final firstWord = words[0][0];
    if (words.length == 1) {
      return firstWord;
    }
    return '$firstWord${words[1][0]}';
  }
}
