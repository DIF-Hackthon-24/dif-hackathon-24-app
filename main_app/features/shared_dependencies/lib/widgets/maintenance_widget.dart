// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:core/logging/logger.dart';
import 'package:core/utils/extensions/date_time_extensions.dart';
import 'package:core/utils/extensions/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/ps_scaffold.dart';

class MaintenanceWidgetAttributes {
  final String startTime;
  final String endTime;
  final String appBarText;
  final String title;
  final String description;
  final String pleaseVisitAgainLabel;
  final String daysText;
  final String minutesText;
  final String secondsText;
  final String hoursText;

  MaintenanceWidgetAttributes({
    required this.startTime,
    required this.endTime,
    required this.appBarText,
    required this.title,
    required this.description,
    required this.pleaseVisitAgainLabel,
    required this.daysText,
    required this.minutesText,
    required this.secondsText,
    required this.hoursText,
  });
}

class MaintenanceWidget extends StatefulWidget {
  final MaintenanceWidgetAttributes attributes;
  const MaintenanceWidget({
    super.key,
    required this.attributes,
  });

  @override
  State<MaintenanceWidget> createState() => _MaintenanceWidgetState();
}

class _MaintenanceWidgetState extends State<MaintenanceWidget> {
  String remainingTime = '';
  Timer? _timer;
  StreamController<String> timerStream = StreamController<String>.broadcast();

  @override
  void dispose() {
    try {
      if (_timer != null && _timer!.isActive) _timer!.cancel();
    } catch (e) {
      PSLogger.logError(e.toString());
    }
    super.dispose();
  }

  @override
  void initState() {
    prepareData();
    super.initState();
  }

  void prepareData() {
    DateTime endTime = DateTime.parse(widget.attributes.endTime).toLocal();
    DateTime currentTime = DateTime.now().toLocal();
    var result = const Duration(seconds: 0);
    result = endTime.difference(currentTime);
    remainingTime = result.inSeconds.toString();
  }

  String dayHourMinuteSecondFunction(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String days = twoDigits(duration.inDays);
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (days == "00" && twoDigitHours == "00" && twoDigitMinutes == "00") {
      return "$twoDigitSeconds";
    } else if (days == "00" && twoDigitHours == "00") {
      return twoDigitMinutes + ' : ' + twoDigitSeconds;
    } else if (days == "00") {
      return twoDigitHours + ' : ' + twoDigitMinutes + ' : ' + twoDigitSeconds;
    }
    return days +
        ' : ' +
        twoDigitHours +
        ' : ' +
        twoDigitMinutes +
        ' : ' +
        twoDigitSeconds;
  }

  Widget dateWidget() {
    return StreamBuilder<String>(
        stream: timerStream.stream,
        initialData: "0",
        builder: (cxt, snapshot) {
          const oneSec = Duration(seconds: 1);
          if (_timer != null && _timer!.isActive) _timer!.cancel();
          _timer = Timer.periodic(oneSec, (Timer timer) {
            try {
              int second = int.tryParse(remainingTime) ?? 0;
              second = second - 1;
              if (second < -1) return;
              remainingTime = second.toString();
              if (second == -1) {
                timer.cancel();
              }
              if (second >= 0) {
                timerStream.add(remainingTime);
              }
            } catch (e) {
              PSLogger.logError(e.toString());
            }
          });
          String remainTimeDisplay = "-";
          try {
            int seconds = int.parse(remainingTime);
            var now = Duration(seconds: seconds);
            remainTimeDisplay = dayHourMinuteSecondFunction(now);
          } catch (e) {
            PSLogger.logError(e.toString());
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...getTimer(remainTimeDisplay),
            ],
          );
        });
  }

  List<Widget> getTimer(String remainTimeDisplay) {
    final contentList = remainTimeDisplay.split(':');
    final time = contentList
        .mapIndexed((e, i) => Padding(
              padding: const EdgeInsets.all(DimensionConstants.size5),
              child: Container(
                padding: const EdgeInsets.all(DimensionConstants.size5),
                width: DimensionConstants.size53,
                decoration: BoxDecoration(
                    color: ColorConstants.COLOR_WHITE,
                    borderRadius: BorderRadius.all(
                        Radius.circular(DimensionConstants.size8))),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PSText(
                          text: TextUIDataModel(
                              getContentBasedOnIndex(i, contentList.length),
                              styleVariant: PSTextStyleVariant.headline4)),
                      PSText(
                          text: TextUIDataModel(e.trim(),
                              styleVariant: PSTextStyleVariant.headline5)),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
    return time;
  }

  String getContentBasedOnIndex(int index, int length) {
    switch (length) {
      case 4:
        switch (index) {
          case 0:
            return widget.attributes.daysText;
          case 1:
            return widget.attributes.hoursText;
          case 2:
            return widget.attributes.minutesText;
          case 3:
            return widget.attributes.secondsText;
          default:
            return "";
        }
      case 3:
        switch (index) {
          case 0:
            return widget.attributes.hoursText;
          case 1:
            return widget.attributes.minutesText;
          case 2:
            return widget.attributes.secondsText;
          default:
            return "";
        }
      case 2:
        switch (index) {
          case 0:
            return widget.attributes.minutesText;
          case 1:
            return widget.attributes.secondsText;
          default:
            return "";
        }
      case 1:
        return widget.attributes.secondsText;
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return PSScaffold(
      themeName: 'maintenance_screen',
      appBarAttributes: PSAppBarAttributes(
        title: widget.attributes.appBarText,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: DimensionConstants.size50,
          ),
          PSImage(PSImageModel(iconPath: 'assets/icons/ic_maintenance.svg')),
          const SizedBox(
            height: DimensionConstants.size34,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: DimensionConstants.size40,
                right: DimensionConstants.size40),
            child: PSText(
                text: TextUIDataModel(widget.attributes.title,
                    styleVariant: PSTextStyleVariant.headline1,
                    textAlign: TextAlign.center)),
          ),
          const SizedBox(
            height: DimensionConstants.size20,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: DimensionConstants.size40,
                right: DimensionConstants.size40),
            child: PSText(
              text: TextUIDataModel(
                  widget.attributes.description
                      .replaceAll(
                          '<>',
                          DateTime.parse(widget.attributes.startTime)
                              .toUtc()
                              .toLocal()
                              .toDateWithSlashAndTime())
                      .replaceAll(
                          '#',
                          DateTime.parse(widget.attributes.endTime)
                              .toUtc()
                              .toLocal()
                              .toDateWithSlashAndTime()),
                  styleVariant: PSTextStyleVariant.headline2,
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            height: DimensionConstants.size8,
          ),
          PSText(
              text: TextUIDataModel(widget.attributes.pleaseVisitAgainLabel,
                  styleVariant: PSTextStyleVariant.headline3)),
          const SizedBox(
            height: DimensionConstants.size8,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: DimensionConstants.size40,
                right: DimensionConstants.size40),
            child: dateWidget(),
          ),

        ],
      ),
    );
  }
}
