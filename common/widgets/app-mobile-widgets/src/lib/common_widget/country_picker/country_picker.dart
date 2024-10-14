import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';

class CountryPicker extends StatelessWidget {
  final Function(String)? onValuePicked;
  final Color? backgroundColor;
  final String value;
  final String labelText;
  final String? hintText;
  final String? errorText;

  const CountryPicker({
    Key? key,
    this.onValuePicked,
    required this.value,
    required this.labelText,
    this.hintText,
    this.errorText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: Key('CountryPicker_Container'),
      height: 62,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorText: errorText,
              errorMaxLines: 4,
              filled: true,
              fillColor: backgroundColor,
              focusColor: backgroundColor,
              hoverColor: backgroundColor,
            ),
            child: CountryPickerDropdown(
              initialValue: value,
              itemBuilder: (country) => _buildDropdownItem(theme.textTheme.bodyLarge, country),
              onValuePicked: (c) {
                onValuePicked?.call(c.isoCode);
              },
              isExpanded: true,
              //icon: getSvg('widget_library:assets/images/ic_arrow_down.svg', width: 24),
              icon: PSImage(
                PSImageModel(
                  iconPath: 'widget_library:assets/images/ic_arrow_down.svg',
                  width: 24
                ),
              ),
              selectedItemBuilder: (country) => Text(
                country.name,
                key: Key('_buildDropdownItemText'),
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownItem(TextStyle? style, Country country) => Container(
        child: Text(
          country.name,
          key: Key(country.isoCode),
          style: style,
        ),
      );
}
