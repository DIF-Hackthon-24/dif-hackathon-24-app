import 'package:core/translation/app_localization.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/search_bar/search_bar_widget_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'package:widget_library/common_widget/utils/debouncer.dart';

class SearchBarWidget extends StatefulWidget {
  final void Function(String) onSearch;
  final void Function(String)? onTextChanged;
  final int debounceDuration;
  final SearchBarAttributes attributes;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final bool? isReadOnly;

  SearchBarWidget({
    required this.onSearch,
    Key? key,
    this.onTextChanged,
    this.debounceDuration = 300,
    this.attributes = const SearchBarAttributes(),
    this.onTap,
    this.focusNode,
    this.autoFocus,
    this.isReadOnly,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState(
        debouncer: Debouncer(
          delay: Duration(milliseconds: debounceDuration),
        ),
      );
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _textFieldController = TextEditingController();
  final Debouncer debouncer;

  _SearchBarWidgetState({required this.debouncer});

  @override
  Widget build(BuildContext context) {
    var _appearance = widget.attributes.appearance;

    return Container(
      key: Key('SearchBarWidget_Container'),
      height: _appearance.height,
      child: TextField(
        key: Key('SearchBarWidget_TextField'),
        onTap: widget.onTap,
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus ?? false,
        style: (widget.attributes.dataModel.variant != null)
            ? buildTextStyle(
                context: context,
                variant: widget.attributes.dataModel.variant!,
              )
            : Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(_appearance.contentPadding),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: PSTheme().themeData.colorPalette!.panelColorPrimary.toColor(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                _appearance.cornerRadius,
              ),
            ),
            borderSide: BorderSide.none,
          ),
          labelText: AppLocalizations.of(context)!.translate(widget.attributes.dataModel.hint),
          labelStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          suffixIcon: IconButton(
            key: Key('SearchBarWidget_IconButton'),
            onPressed: () {
              _textFieldController.text.isEmpty
                  ? widget.onSearch(_textFieldController.text)
                  : {
                      _textFieldController.clear(),
                      widget.onSearch(''),
                    };
            },
            /* icon: getSvg(
              _textFieldController.text.isEmpty
                  ? _appearance.suffixIcon
                  : 'app_mobile_invoice:assets/images/ic_close.svg',
              width: (_appearance.iconWidth ?? 22),
            ), */
            icon: PSImage(
              PSImageModel(
                iconPath: _textFieldController.text.isEmpty
                    ? _appearance.suffixIcon
                    : 'app_mobile_invoice:assets/images/ic_close.svg',
                width: (_appearance.iconWidth ?? 22),
              ),
            ),
          ),
        ),
        onChanged: (predicate) {
          debouncer.run(() {
            widget.onTextChanged?.call(predicate);
          });
        },
        controller: _textFieldController,
        keyboardType: TextInputType.name,
        onSubmitted: widget.onSearch,
        readOnly: widget.isReadOnly ?? false,
      ),
    );
  }
}
