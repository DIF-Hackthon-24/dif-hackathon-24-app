import 'package:flutter/widgets.dart';
import 'package:widget_library/common_widget/card/view_card_detail/bottom_modal_sheet.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/vertical_actionbar/ps_vertical_action_bar.dart';

class _Constants {
  static const iconSpacing = 8.0;
  static const sectionHeight = 64.0;
  static const rightPadding = 24.0;
}

class AccountDetailsSectionHeaderWidget extends StatelessWidget {
  final String title;
  final PSTextStyleVariant? titleStyle;
  final List<ActionModel>? actions;
  final double iconSpacing;
  final double leftPadding;
  final double rightPadding;
  final bool isUpperCase;
  final PSImageModel? icon;
  final bool showActions;
  const AccountDetailsSectionHeaderWidget({
    Key? key,
    required this.title,
    this.titleStyle = PSTextStyleVariant.headline6,
    this.actions,
    this.iconSpacing = _Constants.iconSpacing,
    this.leftPadding = Constants.borderPadding,
    this.rightPadding = _Constants.rightPadding,
    this.isUpperCase = true,
    this.icon,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final actionIcons = _actionWidgets(
      context,
      actions,
    );
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: SizedBox(
        key: Key('AccountDetailsSectionHeaderWidget_SizedBox'),
        height: _Constants.sectionHeight,
        child: Row(children: <Widget>[
          SizedBox(
            key: Key('AccountDetailsSectionHeaderWidget_ChildrenSizedBox'),
            width: leftPadding,
          ),
          PSText(
            key: Key('AccountDetailsSectionHeaderWidget_TitleText'),
            text: TextUIDataModel(
              title,
              styleVariant: titleStyle,
            ),
          ),
          Expanded(
            key: Key('AccountDetailsSectionHeaderWidget_Expanded'),
            child: Container(
              key: Key(
                'AccountDetailsSectionHeaderWidget_ExpandedContainer',
              ),
            ),
          ),
          if (showActions) ...actionIcons,
          if (icon != null) PSImage(icon!),
          SizedBox(
            key: Key('AccountDetailsSectionHeaderWidget_BottomSizedBox'),
            width: rightPadding,
          ),
        ]),
      ),
    );
  }

  List<Widget> _actionWidgets(
    BuildContext context,
    List<ActionModel>? actions,
  ) {
    if (actions != null) {
      final icons = actions
          .map<Widget>(
            (item) => GestureDetector(
              onTap: () {
                if (item.action != null) {
                  item.action!();
                }
              },
              child: PSImage(
                PSImageModel(
                  iconPath: item.iconUri!,
                ),
              ),
            ),
          )
          .toList();
      return List<Widget>.generate(icons.length * 2, (index) {
        return index.isEven
            ? icons[index ~/ 2]
            : SizedBox(
                key: Key('$index'),
                width: iconSpacing,
              );
      });
    }
    return <Widget>[];
  }
}
