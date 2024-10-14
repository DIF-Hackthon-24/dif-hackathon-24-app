import 'package:core/translation/app_localization.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

import 'segmented_control_widget_attributes.dart';

class PSSegmentedControlWidget extends StatefulWidget {
  final PSSegmentedControlAttributes attributes;

  const PSSegmentedControlWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  _PSSegmentedControlWidgetState createState() => _PSSegmentedControlWidgetState();
}

class _PSSegmentedControlWidgetState extends State<PSSegmentedControlWidget> {
  var _cornerRadius = 6.0;
  var _currentIndex = 0;
  late Color selectedColor;
  late Color unselectedColor;
  bool tabSelectionFromNavigation = true;

  @override
  void initState() {
    super.initState();
    _cornerRadius = widget.attributes.cornerRadius!;
    unselectedColor =
        widget.attributes.inactiveBgColor ?? PSTheme().defaultThemeData.segmentedThemeData!.color.toColor();
    selectedColor =
        widget.attributes.activeBgColor ?? PSTheme().defaultThemeData.segmentedThemeData!.textColor.toColor();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.attributes.titles.isNotEmpty);

    if (widget.attributes.initialIndex != null && tabSelectionFromNavigation) {
      _currentIndex = widget.attributes.initialIndex!;
    }
    if (widget.attributes.isControlledByParent) {
      _currentIndex = widget.attributes.defaultIndex;
    }

    tabSelectionFromNavigation = true;

    return Container(
      width: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: unselectedColor,
        borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)),
      ),
      key: Key('PSSegmentedControlWidget_Container'),
      child: widget.attributes.titles.length > 1
          ? CupertinoSegmentedControl<int>(
              key: Key('PSSegmentedControlWidget_CupertinoSegmentedControl'),
              padding: EdgeInsets.all(0),
              borderColor: Colors.transparent,
              unselectedColor: Colors.transparent,
              selectedColor: Colors.transparent,
              groupValue: _currentIndex,
              children: widget.attributes.titles.asMap().map(
                    (index, title) => MapEntry(
                      index,
                      _getItem(title, index),
                    ),
                  ),
              onValueChanged: (value) {
                tabSelectionFromNavigation = false;
                if (!widget.attributes.isControlledByParent) {
                  setState(() {
                    _currentIndex = value;
                  });
                }
                if (widget.attributes.onSelectAction != null) {
                  widget.attributes.onSelectAction!(value);
                }
              },
            )
          : _getItem(widget.attributes.titles.first, 0),
    );
  }

  Widget _getItem(TextUIDataModel text, int itemIndex) {
    return Container(
      key: Key('PSSegmentedControlWidget_getItem_Container'),
      decoration: _getBoxDecoration(itemIndex),
      height: widget.attributes.height,
      width: widget.attributes.fixedWidth ??
          (MediaQuery.of(context).size.width - widget.attributes.horizontalPadding) / widget.attributes.titles.length,
      child: Center(
        key: Key('PSSegmentedControlWidget_getItem_Center'),
        child: PSText(
          key: Key('PSSegmentedControlWidget_getItem_Text'),
          text: TextUIDataModel(
            AppLocalizations.of(context)!.translate(text.text),
            styleVariant: _currentIndex == itemIndex ? PSTextStyleVariant.subtitle1 : PSTextStyleVariant.subtitle2,
          ),
        ),
      ),
    );
  }

  // ignore: code-metrics
  BoxDecoration _getBoxDecoration(int index) {
    final lastIndex = widget.attributes.titles.length - 1;
    if (index == 0) {
      return BoxDecoration(
        color: _getBackgroundColor(index),
        borderRadius: _currentIndex == index ? _selectedBorderRadius() : _unselectedFirstBorderRadius(),
      );
    } else if (index == lastIndex) {
      return BoxDecoration(
        color: _getBackgroundColor(index),
        borderRadius: _currentIndex == index ? _selectedBorderRadius() : _unselectedLastBorderRadius(),
      );
    } else {
      return BoxDecoration(
        color: _getBackgroundColor(index),
        borderRadius: (_currentIndex == index) ? _selectedBorderRadius() : BorderRadius.zero,
      );
    }
  }

  BorderRadius _unselectedLastBorderRadius() =>
      BorderRadius.only(topRight: Radius.circular(_cornerRadius), bottomRight: Radius.circular(_cornerRadius));

  BorderRadius _unselectedFirstBorderRadius() =>
      BorderRadius.only(topLeft: Radius.circular(_cornerRadius), bottomLeft: Radius.circular(_cornerRadius));

  BorderRadius _selectedBorderRadius() => BorderRadius.all(Radius.circular(_cornerRadius));

  Color _getBackgroundColor(int index) => _currentIndex == index ? selectedColor : unselectedColor;
}
