import 'dart:io';

import 'package:core/translation/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/input_field/input_field_decoration.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/string_extensions.dart';

class _Constant {
  static const paddingHorizontal = 15.0;
  static const paddingTop = 12.0;
  static const paddingBottom = 10.0;
}

/// Received String title to display default Text or builder function to build selectable items.
/// One of two is required
class PSDropdown extends StatefulWidget {
  final String? title;
  final Widget Function(BuildContext)? builder;
  final List<String> variants;
  final String? defaultVariant;
  final Function(String)? onSelected;
  final Color? bgColor;
  final Color? suffixIconColor;
  final bool showHint;
  final String? hintText;
  final Size? iconSize;
  final double contentTopPadding;
  final double contentBottomPadding;
  final double contentLeftPadding;
  final double contentRightPadding;
  final bool isRtl;

  //todo why use showError when you can just pass errorText as null?
  final bool showError;
  final String? errorText;
  final VoidCallback? onTap;
  final Widget? prefix;
  final bool isDisabled;
  @override
  final Key? key;

  PSDropdown({
    this.title,
    this.builder,
    this.iconSize = const Size(24, 12),
    required this.variants,
    this.defaultVariant,
    this.onSelected,
    this.suffixIconColor,
    this.bgColor,
    this.showError = false,
    this.errorText,
    this.onTap,
    this.prefix,
    this.showHint = false,
    this.hintText = ' ',
    this.isDisabled = false,
    this.isRtl = false,
    this.contentTopPadding = _Constant.paddingTop,
    this.contentLeftPadding = _Constant.paddingHorizontal,
    this.contentRightPadding = _Constant.paddingHorizontal,
    this.contentBottomPadding = _Constant.paddingBottom,
    this.key,
  });

  @override
  _PSDropdownState createState() => _PSDropdownState();
}

// ignore: code-metrics, long-method
class _PSDropdownState extends State<PSDropdown> {
  Widget get suffix {
    Widget content = 'widget_library:assets/images/ic_arrow_down.svg'.getSvg(
      color: widget.suffixIconColor,
      size: widget.iconSize,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: widget.title == null || widget.title!.isEmpty
          ? content
          : Padding(
              padding: const EdgeInsets.only(bottom: _Constant.paddingTop),
              child: content,
            ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) => PsFieldInputDecoration(
        context: context,
        labelText: widget.title == null ? null : AppLocalizations.of(context)!.translate(widget.title!),
        bgColor: widget.bgColor,
        errorText: widget.showError ? (widget.errorText ?? '') : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.fromLTRB(
          widget.contentLeftPadding,
          widget.contentTopPadding,
          widget.contentLeftPadding,
          widget.contentBottomPadding,
        ),
      ).copyWith(
        prefixIcon: widget.prefix != null
            ? Padding(
                padding: const EdgeInsets.all(14.0),
                child: widget.prefix,
              )
            : null,
      );

  final dropdownState = GlobalKey<FormFieldState>();

  String? selectedVariant;

  bool _isVariantInPossibleValues() => widget.variants.contains(widget.defaultVariant);

  @override
  void initState() {
    selectedVariant = _isVariantInPossibleValues() ? widget.defaultVariant : null;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    selectedVariant =
        _isVariantInPossibleValues() ? widget.defaultVariant : null;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS && !widget.isDisabled ? _buildIosGestureWrapper(context) : _buildDropDown(context);
  }

  /// Wraps DropDown widget to ignore click on it and displays ios styled CupertinoPicker instead
  GestureDetector _buildIosGestureWrapper(BuildContext context) => GestureDetector(
        onTap: () async {
          final selection = await showModalBottomSheet<String>(
            context: context,
            builder: (BuildContext context) => _IosItemPicker<String>(
              variants: widget.variants,
              builder: (context, item) => Center(child: _buildSelectWidget(item)),
              onItemSelected: (item) {
                Navigator.of(context).pop();
                _onItemSelected(item);
              },
            ),
          );

          if (selection != null) {
            widget.onSelected?.call(selection);
          }
        },
        child: _buildDropDown(context),
      );

  DropdownButtonHideUnderline _buildDropDown(BuildContext context) => DropdownButtonHideUnderline(
        child: Directionality(
          textDirection: widget.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: DropdownButtonFormField<String>(
            key: widget.key,
            onTap: widget.onTap,
            decoration: _inputDecoration(context),
            value: widget.variants.contains(selectedVariant) ? selectedVariant : null,
            isExpanded: true,
            items: widget.variants
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: _buildSelectWidget(value),
                  ),
                )
                .toList(),
            icon: suffix,
            onChanged: widget.isDisabled ? null : _onItemSelected,
            //hint: Text(widget.hintText!),
          ),
        ),
      );

  void _onItemSelected(String? value) {
    setState(() {
      selectedVariant = value;
      // Take focus off the other fields when selecting
      FocusManager.instance.primaryFocus?.unfocus();
    });
    if (value != null) {
      widget.onSelected?.call(value);
    }
  }

  Widget _buildSelectWidget(String value) => PSText(
        text: TextUIDataModel(
          value,
          styleVariant: PSTextStyleVariant.headline4,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
}

class _IosItemPicker<T> extends StatefulWidget {
  const _IosItemPicker({
    Key? key,
    required this.variants,
    required this.builder,
    this.onItemSelected,
  }) : super(key: key);

  final List<T> variants;
  final Widget Function(BuildContext, T) builder;
  final Function(T)? onItemSelected;

  @override
  __IosItemPickerState<T> createState() => __IosItemPickerState<T>();
}

class __IosItemPickerState<T> extends State<_IosItemPicker<T>> {
  final gray4 = Color(0xFFF2F2F2);
  final gray6 = Color(0xFFBDBDBD);
  final blue1 = Color(0xFF2F80ED);

  late T selectedItem = widget.variants.first;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: gray4,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () => widget.onItemSelected?.call(selectedItem),
                  child: Text(
                    'Done',
                    key: Key('PSDropdown_BuildPicker_DoneText'),
                    style: TextStyle(color: blue1, fontSize: 18),
                  ),
                ),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedItem = widget.variants[index];
                  });
                },
                itemExtent: 56,
                children: widget.variants.map<Widget>((value) => widget.builder(context, value)).toList(),
              ),
            ),
          ],
        ),
      );
}
