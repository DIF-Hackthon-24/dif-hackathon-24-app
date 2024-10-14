import 'package:core/translation/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/spannable_text_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/string_extensions.dart';

class InfoBulletItemWidgetAttributes {
  final String? icon;
  final String? textBold;
  final String? textNormal;
  final bool showInfo;

  InfoBulletItemWidgetAttributes({
    this.icon,
    this.textBold,
    this.textNormal,
    this.showInfo = false,
  });
}

class InfoBulletItemUIDataModel {
  final InfoBulletItemWidgetAttributes state;
  final String? suffixIcon;
  final VoidCallback? onTap;

  InfoBulletItemUIDataModel({
    required this.state,
    this.suffixIcon,
    this.onTap,
  });
}

class InfoBulletItemsGroupWidget extends StatelessWidget {
  final List<InfoBulletItemUIDataModel> bullets;

  InfoBulletItemsGroupWidget({required this.bullets});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('InfoBulletItemsGroupWidget_Column'),
      mainAxisSize: MainAxisSize.min,
      children: [
        ...bullets.map(
          (bullet) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InfoBulletItemWidget(bullet),
          ),
        ),
      ],
    );
  }
}

class InfoBulletItemWidget extends StatelessWidget {
  final InfoBulletItemUIDataModel bullet;

  InfoBulletItemWidget(this.bullet);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('InfoBulletItemWidget_InkWell'),
      onTap: bullet.onTap,
      child: Row(
        key: Key('InfoBulletItemWidget_Row'),
        children: [
          if (bullet.state.icon != null) bullet.state.icon!.toSvg,
          Padding(padding: const EdgeInsets.only(left: 10.0)),
          SpannedTextWidget(
            key: Key('InfoBulletItemWidget_SpannedTextWidget'),
            texts: [
              TextUIDataModel(AppLocalizations.of(context)!.translate(bullet.state.textBold!)),
              TextUIDataModel(AppLocalizations.of(context)!.translate(bullet.state.textNormal!)),
            ],
          ),
          if (bullet.suffixIcon != null)
            Padding(
              key: Key('InfoBulletItemWidget_Padding'),
              padding: const EdgeInsets.only(left: 6.0),
              child: bullet.suffixIcon!.toSvg,
            ),
        ],
      ),
    );
  }
}
