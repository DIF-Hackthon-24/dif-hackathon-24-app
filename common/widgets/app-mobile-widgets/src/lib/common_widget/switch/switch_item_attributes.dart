import 'package:widget_library/common_widget/static_text/PSText.dart';

class SwitchItemAttributes {
  final Function(bool)? onSwitch;
  final Function? onTap;
  final bool isOn;
  final String subtitle;
  final String title;
  final PSTextStyleVariant titleStyle;
  final PSTextStyleVariant subTitleStyle;
  const SwitchItemAttributes({
    this.onSwitch,
    this.onTap,
    this.isOn = false,
    this.title = '',
    this.subtitle = '',
    this.titleStyle = PSTextStyleVariant.headline4,
    this.subTitleStyle = PSTextStyleVariant.headline5,
  });

  SwitchItemAttributes copyWith({
    final Function(bool)? onSwitch,
    final Function? onTap,
    final bool? isOn,
    final String? subTitle,
    final String? title,
    final PSTextStyleVariant? titleStyle,
    final PSTextStyleVariant? subTitleStyle,
  }) {
    return SwitchItemAttributes(
      onSwitch: onSwitch ?? this.onSwitch,
      onTap: onTap ?? this.onTap,
      isOn: isOn ?? this.isOn,
      subtitle: subTitle ?? subtitle,
      title: title ?? this.title,
      titleStyle: titleStyle ?? this.titleStyle,
      subTitleStyle: subTitleStyle ?? this.subTitleStyle,
    );
  }
}
