import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

class TimerWidget extends StatefulWidget {
  final int? durationInSeconds;

  TimerWidget({this.durationInSeconds = 60, Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  late int durationInSeconds;
  @override
  void initState() {
    durationInSeconds = widget.durationInSeconds ?? 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (durationInSeconds == 0) {
        setState(() {
          _timer?.cancel();
        });
      } else {
        setState(() {
          durationInSeconds--;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var timeInMinutes = (durationInSeconds / 60).floor();
    var timeInMinutesString = timeInMinutes < 10 ? '0$timeInMinutes' : '$timeInMinutes';
    var timeInSecondsString = durationInSeconds % 60 >= 10 ? durationInSeconds % 60 : '0${durationInSeconds % 60}';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PSText(
          text: TextUIDataModel(
            '$timeInMinutesString : $timeInSecondsString',
            styleVariant: PSTextStyleVariant.bodyText2,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
