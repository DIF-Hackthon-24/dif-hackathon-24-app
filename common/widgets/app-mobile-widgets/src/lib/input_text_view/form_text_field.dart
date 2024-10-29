import 'package:core/translation/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/input_field/input_field_decoration.dart';

typedef FormTextFieldValidator = String? Function(String? value);

class _Constant {
  static const paddingHorizontal = 15.0;
  static const paddingTop = 12.0;
  static const paddingBottom = 10.0;
}

class FormTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? nextFocusNode;
  final Function(String)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? formatters;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextStyle? hintStyle;
  final String? hint;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? helpText;
  final String? errorText;
  final bool isRequired;
  final bool isObscured;
  final int maxLines;
  final int? maxLength;
  final Widget? suffix;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final String? initialValue;
  final bool showLabel;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool readOnly;
  final bool? isEnabled;
  final VoidCallback? onTap;
  final bool showClearOnError;
  final bool enableInteractiveSelection;
  final String? prefixText;
  final InputBorder? border;
  final bool filled;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool isSuffixIconEnable;
  final EdgeInsets? contentPadding;
  final bool isRtl;

  const FormTextField({
    Key? key,
    this.validator,
    this.hint,
    this.onSubmitted,
    this.onChanged,
    this.nextFocusNode,
    this.formatters,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.isRequired = true,
    this.isObscured = false,
    this.suffix,
    this.isSuffixIconEnable = true,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.textStyle,
    this.helpText,
    this.backgroundColor,
    this.initialValue,
    this.controller,
    this.showLabel = false,
    this.errorText,
    this.maxLines = 1,
    this.onTap,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.maxLength,
    this.readOnly = false,
    this.showClearOnError = true,
    this.isEnabled,
    this.border,
    this.enableInteractiveSelection = true,
    this.prefixText,
    this.filled = true,
    this.focusNode,
    this.autoFocus = false,
    this.contentPadding,
    this.isRtl = false,
  }) : super(key: key);

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final AutovalidateMode _autoValidate = AutovalidateMode.onUserInteraction;
  bool showLabel = false;
  bool isValid = false;
  bool showError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _controller.text.length,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant FormTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    showError = widget.errorText != null;
    if (widget.controller == null && _controller.text != widget.initialValue) {
      // If we are managing the controller and the initial value is not the same,
      // the app has programatically changed the value, e.g. injecting new bank name
      _controller.text = widget.initialValue!;
    }
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      widget.validator?.call(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      key: Key('FormTextField_Column'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          inputFormatters: [
            // ...widget.formatters ?? <TextInputFormatter>[],
            // FilteringTextInputFormatter.deny('"'),
          ],
          key: widget.key,
          onTap: widget.onTap,
          //! older condition was breaking rtl alignment
          textAlign: TextAlign.start,
          style: widget.textStyle ?? theme.textTheme.bodyLarge,
          controller: _controller,
          scrollController: ScrollController(),
          keyboardType: widget.textInputType,
          focusNode: _focusNode,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          obscureText: widget.isObscured,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          enabled: widget.isEnabled,
          onEditingComplete: () => widget.validator?.call(_controller.text),
          autovalidateMode: _autoValidate,
          onFieldSubmitted: (String value) {
            if (widget.textInputAction == TextInputAction.next) {
              // Move focus to next field down the form
              FocusScope.of(context).focusInDirection(TraversalDirection.down);
            }
            widget.onSubmitted?.call(value);
          },
          decoration: PsFieldInputDecoration(
            errorMaxLines: 4,
            context: context,
            labelText: widget.labelText != null ? AppLocalizations.of(context)!.translate(widget.labelText!) : null,
            labelStyle: widget.labelStyle,
            hintText: widget.hint != null ? AppLocalizations.of(context)!.translate(widget.hint!) : null,
            hintStyle: widget.hintStyle,
            helperText: widget.helpText,
            bgColor: widget.backgroundColor,
            errorText: showError
                ? widget.errorText != null
                    ? AppLocalizations.of(context)!.translate(widget.errorText!)
                    : null
                : null,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            filled: widget.filled,
            alignLabelWithHint: widget.maxLines > 1,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.fromLTRB(
                  _Constant.paddingHorizontal,
                  _Constant.paddingTop,
                  _Constant.paddingHorizontal,
                  _Constant.paddingBottom,
                ),
          ).copyWith(
            suffixIcon: widget.isSuffixIconEnable ? _buildSuffix() : null,
            prefix: widget.prefixText != null
                ? Text(
                    widget.prefixText!,
                    style: widget.textStyle,
                  )
                : null,
          ),
          readOnly: widget.readOnly,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          autofocus: widget.autoFocus,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    if (widget.controller == null) {
      // Controller was created by us, so dispose of it
      _controller.dispose();
    }
    super.dispose();
  }

  Widget? _buildSuffix() => widget.showClearOnError && showError
      ? InkWell(
          onTap: () {
            setState(() {
              showError = false;
            });
            _controller.clear();
            widget.onChanged?.call('');
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 15.0, 15.0, 15.0),
            //child: getSvg('widget_library:assets/images/ic_cross.svg'),
            child: PSImage(
              PSImageModel(
                iconPath: 'widget_library:assets/images/ic_cross.svg',
              ),
            ),
          ),
        )
      : widget.suffix;
}
