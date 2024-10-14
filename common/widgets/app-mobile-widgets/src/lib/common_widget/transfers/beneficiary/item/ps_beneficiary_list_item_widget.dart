import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:widget_library/common_widget/buttons/buttons.dart';
import 'package:widget_library/common_widget/buttons/cornered_icon_button.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/list/ps_slideable_list.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/transfers/beneficiary/item/ps_beneficiary_list_item_widget_attributes.dart';

/// This enum will chekc the current screen type and it will be used to display leading icon for [ListTile].
enum PSBeneficiaryListScreenType {
  defaultType,
  invoiceDashboard,
}

class PSBeneficiaryListItemWidget extends StatelessWidget {
  final PSBeneficiaryListItemWidgetAttributes attributes;
  final SlidableController? slidableController;
  final PSBeneficiaryListScreenType? screenType;

  PSBeneficiaryListItemWidget({
    Key? key,
    required this.attributes,
    this.slidableController,
    this.screenType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentScreenType = screenType ?? PSBeneficiaryListScreenType.defaultType;
    final shouldShowIconWidget = currentScreenType == PSBeneficiaryListScreenType.defaultType;
    return PSSlidableList(
      slidableController: slidableController,
      secondaryActions: attributes.slidableActions,
      child: InkWell(
        key: Key('PSBeneficiaryListItemWidget_InkWell'),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(attributes.cardCornerRadius),
          ),
          child: ListTile(
            contentPadding: attributes.contentPadding?.toEdgeInsets(),
            key: Key('PSBeneficiaryListItemWidget_ListTile'),
            onTap: attributes.onTap,
            leading: shouldShowIconWidget
                ? (attributes.iconAttributes != null)
                    ? SizedBox(
                        key: Key('PSBeneficiaryListItemWidget_LeadingSizedBox'),
                        width: attributes.iconAttributes!.width,
                        height: attributes.iconAttributes!.height,
                        child: _buildIcon(context),
                      )
                    : _buildNameCircle(context)
                : null,
            title: PSText(text: attributes.title),
            subtitle: (attributes.subTitle != null) ? PSText(text: attributes.subTitle!) : null,
            trailing: _buildTrailing(),
          ),
        ),
      ),
    );
  }

  Widget? _buildIcon(BuildContext context) {
    if (attributes.iconAttributes != null) {
      switch (attributes.iconAttributes!.type) {
        case PSBeneficiaryListIconType.circle:
          return CircleAvatar(
            key: Key('PSBeneficiaryListItem_buildIcon_CircleAvatar'),
            radius: attributes.iconAttributes!.radius,
            backgroundImage:
                attributes.iconAttributes!.path != null ? NetworkImage(attributes.iconAttributes!.path!) : null,
            backgroundColor: attributes.iconAttributes!.background,
            child: attributes.iconAttributes!.iconTitle != null
                ? PSText(
                    text: TextUIDataModel(getNameInitial(attributes.iconAttributes!.iconTitle!.text),
                        styleVariant: attributes.iconAttributes!.iconTitle!.styleVariant),
                  )
                : null,
          );

        case PSBeneficiaryListIconType.circleWithBorder:
          return CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorDark,
            child: CircleAvatar(
              key: Key('PSBeneficiaryListItem_buildIcon_CircleAvatar'),
              radius: attributes.iconAttributes!.radius,
              backgroundImage:
                  attributes.iconAttributes!.path != null ? NetworkImage(attributes.iconAttributes!.path!) : null,
              backgroundColor: attributes.iconAttributes!.background,
              child: attributes.iconAttributes!.iconTitle != null
                  ? PSText(text: attributes.iconAttributes!.iconTitle!)
                  : null,
            ),
          );

        case PSBeneficiaryListIconType.cornered:
          return PSCorneredIconButton(
            key: Key('PSBeneficiaryListItem_buildIcon_PSCorneredIconButton'),
            svgSource: attributes.iconAttributes!.path,
            buttonType: attributes.iconAttributes!.buttonType,
            buttonText: attributes.iconAttributes!.iconTitle != null
                ? TextUIDataModel(
                    getNameInitial(attributes.iconAttributes!.iconTitle!.text),
                    styleVariant: attributes.iconAttributes!.iconTitle!.styleVariant,
                  )
                : null,
            buttonOverlayStyle: PSButtonOverlayStyle.rounded,
            variant: PSButtonThemeVariant.secondary,
            onPressed: attributes.iconAttributes!.onPressed,
            isBorderEnabled: false,
            buttonStyle: attributes.iconAttributes!.buttonStyle,
            minimumSize: const Size(100, 100),
          );
        case PSBeneficiaryListIconType.assetCircle:
          return CircleAvatar(
              radius: (attributes.iconAttributes!.radius),
              backgroundColor: attributes.iconAttributes!.background,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(attributes.iconAttributes!.radius!),
                child: PSImage(PSImageModel(iconPath: attributes.iconAttributes!.path!)),
              ));
      }
    }
    return null;
  }

  Widget? _buildNameCircle(BuildContext context) {
    if (attributes.iconAttributes == null) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(getNameInitial(attributes.title.text))),
      );
    }
    return null;
  }

  String getNameInitial(String name) {
    String initials = '';
    List<String> fragments = name.trim().split(' ');
    if (fragments.isNotEmpty) {
      initials = fragments[0][0];
    }
    if (fragments.length > 1 && fragments[1] != '') {
      initials += fragments[1][0];
    }
    return initials;
  }

  Widget _buildTrailing() {
    return Column(
      key: Key('PSBeneficiaryListItem_buildTrailing_Column'),
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (attributes.value != null) PSText(text: attributes.value!),
        if (attributes.indicator != null) attributes.indicator!,
      ],
    );
  }
}
