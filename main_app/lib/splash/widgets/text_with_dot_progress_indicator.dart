import 'dart:async';
import 'package:flutter/material.dart';
import 'package:theme_font/color/app_theme_colors.dart';
import 'package:theme_font/font/app_font_style.dart';

class TextWithDotProgressIndicator extends StatefulWidget {
    final String text;
    const TextWithDotProgressIndicator({super.key,required this.text});

  @override
  _TextWithDotProgressIndicatorState createState() => _TextWithDotProgressIndicatorState();
}

class _TextWithDotProgressIndicatorState extends State<TextWithDotProgressIndicator> {
  late Timer _timer;
  String _text='';
  int _dotCount = 1;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _text = "${widget.text}${'.' * _dotCount}";
        _dotCount = _dotCount % 19 + 1;  // Cycle through 1 to 12
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: AppFontStyle.style(
      typography: FontTypography.body03Medium,
      color: AppThemeColors.sandstone25,
    ),
    );
  }
}
