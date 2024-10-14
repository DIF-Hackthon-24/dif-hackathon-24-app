import 'package:flutter/material.dart';

class PSOTPCodeEntry extends StatefulWidget {
  final int fieldsCount;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? preFilledWidget;
  final List<int> separatorPositions;
  final Widget separator;
  final TextStyle? textStyle;
  final BoxDecoration? submittedFieldDecoration;
  final BoxDecoration? selectedFieldDecoration;
  final double? eachFieldWidth;
  final double? eachFieldHeight;
  final MainAxisAlignment fieldsAlignment;
  final AlignmentGeometry eachFieldAlignment;
  final EdgeInsetsGeometry? eachFieldMargin;
  final EdgeInsetsGeometry? eachFieldPadding;
  final bool autofocus;
  final bool withCursor;
  final TextInputType keyboardType = TextInputType.number;
  final MainAxisSize mainAxisSize;
  final String? obscureText;
  const PSOTPCodeEntry({
    Key? key,
    required this.fieldsCount,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.preFilledWidget,
    this.separatorPositions = const [],
    this.separator = const SizedBox(
      width: 15,
    ),
    this.textStyle,
    this.submittedFieldDecoration,
    this.selectedFieldDecoration,
    this.eachFieldWidth,
    this.eachFieldHeight,
    this.fieldsAlignment = MainAxisAlignment.spaceBetween,
    this.eachFieldAlignment = Alignment.center,
    this.eachFieldMargin,
    this.eachFieldPadding,
    this.autofocus = true,
    this.withCursor = true,
    this.mainAxisSize = MainAxisSize.max,
    this.obscureText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PSOTPCodeEntryState();
}

class _PSOTPCodeEntryState extends State<PSOTPCodeEntry> with WidgetsBindingObserver, TickerProviderStateMixin {
  String _currentText = '';
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late ValueNotifier<String> _textControllerValue;

  int get selectedIndex => _controller.value.text.length;

  late Animation _cursorAnimation;
  late AnimationController _cursorAnimationController;

  AnimationController? _obscureTextAnimationController;
  Animation<double>? _obscureTextIn;
  Animation<double>? _obscureTextOut;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _textControllerValue = ValueNotifier<String>(_controller.value.text);
    _controller.addListener(_textChangeListener);
    _focusNode.addListener(() {
      if (mounted) setState(() {});
    });

    if (widget.withCursor) {
      _cursorAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      );
      _cursorAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Curves.linear,
        parent: _cursorAnimationController,
      ));
      _cursorAnimationController.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _cursorAnimationController.repeat(reverse: true);
        }
      });
      _cursorAnimationController.forward();
    }
    if (widget.obscureText != null) {
      _obscureTextAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      );
      _obscureTextIn = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Curves.linear,
        parent: _obscureTextAnimationController!,
      ));
      _obscureTextOut = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.linear,
        parent: _obscureTextAnimationController!,
      ));
    }
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: Key('PSOTPCodeEntry_Stack'),
      children: <Widget>[
        _hiddenTextField,
        _fields,
      ],
    );
  }

  Widget get _hiddenTextField {
    return TextFormField(
      key: Key('PSOTPCodeEntry_hiddenTextFieldTextFormField'),
      controller: _controller,
      focusNode: _focusNode,
      enabled: true,
      enableSuggestions: false,
      autofocus: widget.autofocus,
      autocorrect: false,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        counterStyle: TextStyle(fontSize: 0),
      ),
      keyboardType: widget.keyboardType,
      enableInteractiveSelection: false,
      maxLength: widget.fieldsCount,
      showCursor: false,
      scrollPadding: EdgeInsets.zero,
      style: widget.textStyle != null
          ? widget.textStyle!.copyWith(color: Colors.transparent)
          : const TextStyle(color: Colors.transparent),
    );
  }

  Widget get _fields {
    return ValueListenableBuilder<String>(
      key: Key('PSOTPCodeEntry_ValueListenableBuilder'),
      valueListenable: _textControllerValue,
      builder: (BuildContext context, value, Widget? child) {
        return GestureDetector(
          onTap: _handleTap,
          child: Row(
            key: Key('PSOTPCodeEntry_fieldsRow'),
            mainAxisSize: widget.mainAxisSize,
            mainAxisAlignment: widget.fieldsAlignment,
            children: _buildFieldsWithSeparator(),
          ),
        );
      },
    );
  }

  List<Widget> _buildFieldsWithSeparator() {
    final fields = Iterable<int>.generate(widget.fieldsCount).map((index) {
      return _getField(index);
    }).toList();

    for (final i in widget.separatorPositions) {
      if (i <= widget.fieldsCount) {
        final smaller = widget.separatorPositions.where((int d) => d < i).toList();
        fields.insert(i + smaller.length, widget.separator);
      }
    }

    return fields;
  }

  Widget _getField(int index) {
    final pin = _controller.value.text;
    return Flexible(
      child: Container(
        width: widget.eachFieldWidth,
        height: widget.eachFieldHeight,
        alignment: widget.eachFieldAlignment,
        padding: widget.eachFieldPadding,
        margin: widget.eachFieldMargin,
        decoration: _fieldDecoration(index),
        child: _buildFieldContent(index, pin),
      ),
    );
  }

  BoxDecoration? _fieldDecoration(int index) {
    if (index == selectedIndex && _focusNode.hasFocus) {
      return widget.selectedFieldDecoration;
    }
    return widget.submittedFieldDecoration;
  }

  Widget _buildFieldContent(int index, String pin) {
    if (index < pin.length) {
      if(widget.obscureText == null){
        return Text(
          pin[index],
          key: ValueKey<String>(index < pin.length ? pin[index] : ''),
          style: widget.textStyle,
        );
      }
      return _getAnimatedObscureText(index,pin);
    }

    final isActiveField = index == pin.length;
    final focused = _focusNode.hasFocus;

    if (widget.withCursor && isActiveField && focused) {
      return _buildCursor();
    }

    if (widget.preFilledWidget != null) {
      return SizedBox(
        key: ValueKey<String>(index < pin.length ? pin[index] : ''),
        child: widget.preFilledWidget,
      );
    }
    return Text(
      '',
      key: ValueKey<String>(index < pin.length ? pin[index] : ''),
      style: widget.textStyle,
    );
  }

  Widget _buildCursor() {
    return AnimatedBuilder(
      key: Key('PSOTPCodeEntry_buildCursorAnimatedBuilder'),
      animation: _cursorAnimationController,
      builder: (context, child) {
        return Center(
          key: Key('PSOTPCodeEntry_buildCursorCenter'),
          child: Opacity(
            key: Key('PSOTPCodeEntry_buildCursorOpacity'),
            opacity: _cursorAnimation.value as double,
            child: Text('|', key: Key('PSOTPCodeEntry_buildCursorText'), style: widget.textStyle),
          ),
        );
      },
    );
  }

  void _textChangeListener() {
    final pin = _controller.value.text;

    if (_currentText != pin) {
      if( widget.obscureText != null){
        checkObscureTextAnimation(_currentText,pin);
      }
      _currentText = pin;
      widget.onChanged?.call(_currentText);
      setState(() {});
    }
  }
  Widget _getAnimatedObscureText(int index, String pin) {
    ///only the last digit is animated, all previous are not animated!
    if (index < pin.length-1) {
      return Text(
        widget.obscureText!,
        key: ValueKey<String>(pin[index]),
        style: widget.textStyle,
      );
    }
    ///we need to animate only the last digit
    return _buildObscureText(pin[index],widget.obscureText!);
  }

  Widget _buildObscureText(String char,String obscureText) {
    return AnimatedBuilder(
      key: Key('PSOTPCodeEntry_buildObscureText'),
      animation: _obscureTextAnimationController!,
      builder: (context, child) {
        return Stack(
          children: [
            Center(
              child: Opacity(
                opacity: _obscureTextOut!.value,
                child: Text(char,key: ValueKey<String>(char), style: widget.textStyle),
              ),
            ),
            Center(
              child: Opacity(
                opacity: _obscureTextIn!.value,
                child: Text(obscureText,style: widget.textStyle),
              ),
            ),
          ],
        );
      },
    );
  }

  void checkObscureTextAnimation(String previousPin,String newPin){
    if(previousPin.length < newPin.length){
      ///the new digit is entered,reset animation and start it again
      _obscureTextAnimationController?.reset();
      _obscureTextAnimationController?.forward();
    }else{
      ///one digit is deleted, animate to end.
      _obscureTextAnimationController?.animateTo(1.0);
    }
  }

  void _handleTap() {
    final focus = FocusScope.of(context);
    if (_focusNode.hasFocus) _focusNode.unfocus();
    if (focus.hasFocus) focus.unfocus();
    focus.requestFocus(FocusNode());
    Future.delayed(Duration.zero, () => focus.requestFocus(_focusNode));
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    _cursorAnimationController.dispose();
    _textControllerValue.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
