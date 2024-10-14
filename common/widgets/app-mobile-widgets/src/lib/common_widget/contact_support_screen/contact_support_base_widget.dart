import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/common_widget/contact_support_screen/contact_support_base_widget_attributes.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/ps_scaffold.dart';

class _Constants {
  static const themeName = 'support_contact_info';
  static const facebookIcon = 'widget_library:assets/images/facebook.svg';
  static const twitterIcon = 'widget_library:assets/images/twitter.svg';
  static const instagramIcon = 'widget_library:assets/images/instagram.svg';
  static const youtubeIcon = 'widget_library:assets/images/youtube.svg';
  static const dividerHeight = 1.0;
  static const dividerPadding = 30.0;
  static const socialMediaPadding = 50.0;
  static const contactItemTextPadding = 20.0;
  static const contactItemRadius = 10.0;
  static const contactItemHorizontalPadding = 30.0;
  static const contactItemVerticalPadding = 6.0;
}

// ignore: must_be_immutable
class ContactSupportBaseWidget extends StatelessWidget {
  ContactSupportBaseWidget({Key? key, required this.attributes}) : super(key: key);
  ContactSupportBaseWidgetAttributes attributes;
  @override
  Widget build(BuildContext context) {
    return PSScaffold(
      themeName: _Constants.themeName,
      appBarAttributes: PSAppBarAttributes(
        title: attributes.title,
        left: [
          PSAppBarButtonAttributes(
            type: PSAppBarButtons.back,
          ),
        ],
        right: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildDivider(),
          Column(
            children: attributes.items!.map((e) => _buildContactInfoItem(e)).toList(),
          ),
          _buildDivider(),
          PSText(text: TextUIDataModel(attributes.followUsDesc!, styleVariant: PSTextStyleVariant.normal)),
          _buildSocialMedia(),
        ],
      ),
    );
  }
}

Widget _buildContactInfoItem(ContactInfoItem item) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: _Constants.contactItemHorizontalPadding,
      vertical: _Constants.contactItemVerticalPadding,
    ),
    child: InkWell(
      onTap: item.action!,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_Constants.contactItemRadius),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(_Constants.contactItemTextPadding),
          child: PSText(
            text: TextUIDataModel(
              item.title,
              styleVariant: PSTextStyleVariant.bodyText2,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildDivider() {
  return Padding(
    padding: const EdgeInsets.all(_Constants.dividerPadding),
    child: Container(
      height: _Constants.dividerHeight,
      color: PSTheme().themeData.colorPalette?.panelColorPrimary.toColor(),
      width: double.infinity,
    ),
  );
}

Widget _buildSocialMedia() {
  return Padding(
    padding: const EdgeInsets.all(_Constants.socialMediaPadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: PSImage(PSImageModel(iconPath: _Constants.facebookIcon)),
          onPressed: null,
        ),
        IconButton(
          icon: PSImage(PSImageModel(iconPath: _Constants.twitterIcon)),
          onPressed: null,
        ),
        IconButton(
          icon: PSImage(PSImageModel(iconPath: _Constants.instagramIcon)),
          onPressed: null,
        ),
        IconButton(
          icon: PSImage(PSImageModel(iconPath: _Constants.youtubeIcon)),
          onPressed: null,
        ),
      ],
    ),
  );
}
