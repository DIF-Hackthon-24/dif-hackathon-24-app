import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class _Constants {
  static const topMargin = 16.0;
  static const leftMargin = 32.0;
  static const bottomMargin = 16.0;
  static const rightMargin = 32.0;
  static const topSubTitleMargin = 3.0;
}

class SwitchItemWidget extends StatelessWidget {
  final String title;
  final PSTextStyleVariant titleStyle;
  final String? subTitle;
  final PSTextStyleVariant subTitleStyle;
  final bool dividerRightMargin;
  final bool preValue;
  final bool enabled;
  final Function? onChange;
  final Function? onTap;

  const SwitchItemWidget({
    Key? key,
    required this.title,
    this.preValue = false,
    this.enabled = true,
    this.onChange,
    this.onTap,
    this.subTitle,
    this.dividerRightMargin = false,
    this.titleStyle = PSTextStyleVariant.headline6,
    this.subTitleStyle = PSTextStyleVariant.headline5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('SwitchItemWidget_Container'),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: _Constants.topMargin,
        left: _Constants.leftMargin,
      ),
      child: Column(
        key: Key('SSwitchItemWidget_Column'),
        children: [
          Row(
            key: Key('SwitchItemWidget_ChildrenRow'),
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (preValue && onTap != null) {
                      onTap!();
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        key: Key('SwitchItemWidget_ChildrenExpanded'),
                        child: PSText(
                          text: TextUIDataModel(title, styleVariant: titleStyle),
                        ),
                      ),
                      Visibility(
                        visible: subTitle != null,
                        child: Flexible(
                          key: Key('SwitchItemWidget_subTitle'),
                          child: Padding(
                            padding: const EdgeInsets.only(top: _Constants.topSubTitleMargin),
                            child: PSText(
                              text: TextUIDataModel(subTitle ?? '', styleVariant: subTitleStyle),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: _Constants.rightMargin),
                child: CupertinoSwitch(
                  key: Key('SwitchItemWidget_CupertinoSwitch'),
                  value: preValue,
                  activeColor: Theme.of(context).primaryColorDark,
                  onChanged: enabled
                      ? (value) {
                          onChange!(value);
                        }
                      : null,
                ),
              ),
            ],
          ),
          SizedBox(key: Key('SettingsListSwitchItemWidget_HeightSizedBox'), height: _Constants.bottomMargin),
          Padding(
            padding: EdgeInsets.only(right: dividerRightMargin ? _Constants.rightMargin : 0),
            child: Divider(
              key: Key('SettingsListSwitchItemWidget_HeightDivider'),
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
