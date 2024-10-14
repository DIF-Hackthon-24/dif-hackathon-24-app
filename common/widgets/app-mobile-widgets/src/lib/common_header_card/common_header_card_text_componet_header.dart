import 'package:flutter/material.dart';

import 'common_header_card_description.dart';
import 'common_header_card_subtitle.dart';
import 'common_header_card_title.dart';

class _Constant {
  _Constant._();
  // static const String emptyString = '';

  static const double subtitlePadding = 2;
  static const double descriptionPadding = 10;
}

class CommonHeaderCardTextComponentSectionAttributes {
  final bool isRTL;
  final String? title;
  final String? subtitle;
  final String? description;
  CommonHeaderCardTextComponentSectionAttributes({
    this.isRTL = false,
    this.title,
    this.subtitle,
    this.description,
  });
}

class CommonHeaderCardTextComponentSection extends StatelessWidget {
  const CommonHeaderCardTextComponentSection({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final CommonHeaderCardTextComponentSectionAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: attributes.isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (attributes.title != null)
            CommonHeaderCardTitle(
              attributes: CommonHeaderCardTitleAttributes(
                title: attributes.title!,
              ),
            ),
          if (attributes.title != null)
            const SizedBox(
              height: _Constant.subtitlePadding,
            ),
          if (attributes.subtitle != null)
            CommonHeaderCardSubtitle(
              attributes: CommonHeaderCardSubtitleAttributes(
                subtitle: attributes.subtitle!,
              ),
            ),
          if (attributes.subtitle != null)
            const SizedBox(
              height: _Constant.descriptionPadding,
            ),
          if (attributes.description != null)
            CommonHeaderCardDescription(
              attributes: CommonHeaderCardDescriptionAttributes(
                description: attributes.description!,
              ),
            ),
        ],
      ),
    );
  }
}
