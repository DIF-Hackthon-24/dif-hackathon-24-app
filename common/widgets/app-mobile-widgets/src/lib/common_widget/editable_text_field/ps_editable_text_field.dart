import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:widget_library/common_widget/editable_text_field/ps_editable_text_field_attributes.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/input_field/ps_text_field.dart';

class PSEditableTextField extends StatefulWidget {
  final PsEditableTextFieldAttributes attributes;
  final double height;

  const PSEditableTextField({
    Key? key,
    required this.attributes,
    this.height = 50,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<PSEditableTextField> {
  bool _editable = false;

  late String _hint;
  TextEditingController controller = TextEditingController();
  late TextInputType? _keyboardType;
  late AsyncValidator? _asyncValidator;
  late bool _inProgress;
  late String? _errorMessage;

  @override
  void initState() {
    super.initState();

    controller.text = widget.attributes.initialValue ?? '';
    _hint = widget.attributes.hint;
    _asyncValidator = widget.attributes.asyncValidator;
    _inProgress = widget.attributes.inProgress;
    _keyboardType = widget.attributes.type;
    _errorMessage = widget.attributes.errorMessage;

    if (widget.attributes.validateInitialValue) {
      _onSubmitted(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: Key('PSEditableTextField_Stack'),
      alignment: Alignment.center,
      children: [
        Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              _onSubmitted(controller.text);
            }
          },
          child: PSTextField(
            key: Key('PSEditableTextField_PSTextField'),
            attributes: PSTextFieldAttributes(
              prefix: widget.attributes.prefixIcon != null ? _buildPrefix() : null,
              key: Key('PSEditableTextField_Attributes'),
              labelText: _hint,
              textEditingController: controller,
              errorText: _errorMessage,
              enabled: _inProgress ? false : _editable,
              keyboardType: _keyboardType ?? TextInputType.text,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
              autoFocus: widget.attributes.autoFocus,
              fontSize: widget.attributes.fontSize,
              onSubmitted: _onSubmitted,
              // backgroundColor: _editable ? theme.colorStyles.backgroundColors.secondary.color : null,
            ),
          ),
        ),
        _buildSuffix(),
        _buildProgress(),
      ],
    );
  }

  Visibility _buildSuffix() {
    return Visibility(
      key: Key('PSEditableTextField_buildSuffix_Visibility'),
      visible: !_editable,
      child: Positioned(
        key: Key('PSEditableTextField_buildSuffix_Positioned'),
        right: 0,
        child: InkWell(
          key: Key('PSEditableTextField_buildSuffix_InkWell'),
          onTap: _onEditToggle,
          child: Padding(
            key: Key('PSEditableTextField_buildSuffix_Padding'),
            padding: EdgeInsets.only(
              top: widget.attributes.suffixPadding.top,
              bottom: widget.attributes.suffixPadding.bottom,
              left: widget.attributes.suffixPadding.left,
              right: widget.attributes.suffixPadding.right,
            ),
            child: SvgPicture.asset(
              widget.attributes.suffixIcon,
              key: Key('PSEditableTextField_buildSuffix_SvgPicture'),
              package: 'widget_library',
              width: widget.attributes.suffixPadding.width,
              height: widget.attributes.suffixPadding.height,
              // color: widget.attributes.suffixIconColor ?? theme.colorStyles.staticTextColors.primary.color,
            ),
          ),
        ),
      ),
    );
  }

  Visibility _buildPrefix() {
    return Visibility(
      visible: !_editable,
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.only(
            top: widget.attributes.prefixPadding.top,
            bottom: widget.attributes.prefixPadding.bottom,
            left: widget.attributes.prefixPadding.left,
            right: widget.attributes.prefixPadding.right,
          ),
          /* child: getSvg(
            widget.attributes.prefixIcon!,
            width: widget.attributes.prefixPadding.width,
          ), */
          child: PSImage(
            PSImageModel(
              iconPath: widget.attributes.prefixIcon!,
              width: widget.attributes.prefixPadding.width,
            ),
          ),
        ),
      ),
    );
  }

  Visibility _buildProgress() {
    return Visibility(
      key: Key('PSEditableTextField_buildProgress_Visibility'),
      visible: _inProgress,
      child: Positioned(
        key: Key('PSEditableTextField_buildProgress_Positioned'),
        right: 15,
        child: CupertinoActivityIndicator(
          key: Key('PSEditableTextField_buildProgress_CupertinoActivityIndicator'),
          radius: widget.attributes.progressRadius,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _onEditToggle() {
    setState(() => _editable = !_editable);
  }

  void _onSubmitted(String value) async {
    if (_asyncValidator == null) {
      widget.attributes.onSubmitSuccess(value);
      setState(() {
        _editable = false;
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _inProgress = true;
      _errorMessage = null;
    });

    final validator = _asyncValidator!;
    final errorMessage = await validator(value);
    setState(() {
      _inProgress = false;
    });

    if (errorMessage == null) {
      _onSubmitSuccess(value);
    } else {
      setState(() {
        _errorMessage = errorMessage;
        _inProgress = false;
      });
    }
  }

  void _onSubmitSuccess(String value) {
    widget.attributes.onSubmitSuccess(value);
    setState(() {
      _errorMessage = null;
      _editable = false;
    });
  }
}
