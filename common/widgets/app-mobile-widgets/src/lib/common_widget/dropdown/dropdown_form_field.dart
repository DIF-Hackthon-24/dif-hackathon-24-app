import 'package:flutter/material.dart';

class DropdownFormField extends StatelessWidget {
  final List<String> values;
  final Function(String) onValuePicked;
  final TextStyle? labelStyle;
  final String? label;
  final String? value;

  const DropdownFormField({
    Key? key,
    required this.values,
    required this.onValuePicked,
    this.labelStyle,
    this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      key: Key('DropdownFormField_Stack'),
      children: [
        Container(
          key: Key('DropdownFormField_Container'),
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 62,
          color: theme.inputDecorationTheme.fillColor,
          child: Center(
            key: Key('DropdownFormField_Center'),
            child: Padding(
              key: Key('DropdownFormField_Padding'),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: DropdownButton<String>(
                key: Key('DropdownFormField_DropdownButton'),
                items: values.map((String value) {
                  return DropdownMenuItem<String>(
                    key: Key('DropdownFormField_DropdownMenuItem'),
                    value: value,
                    child: Text(
                      value,
                      key: Key('DropdownFormField_Text'),
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }).toList(),
                isExpanded: true,
                value: value,
                onChanged: (s) {
                  onValuePicked.call(
                    s.toString(),
                  );
                },
              ),
            ),
          ),
        ),
        Align(
          key: Key('DropdownFormField_Align'),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label ?? '',
              key: Key('DropdownFormField_LabelText'),
              style: labelStyle,
            ),
          ),
        ),
      ],
    );
  }
}
