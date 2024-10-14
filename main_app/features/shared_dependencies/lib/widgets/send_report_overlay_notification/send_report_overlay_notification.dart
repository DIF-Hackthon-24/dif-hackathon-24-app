import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import 'send_report_overlay_notification_attributes.dart';
import 'package:core/media_query/ps_media_query.dart';

class _Constants {
  static const sendReportApiErrorTheme = 'send_report_api_error';
  static const closeButtonIcon = 'assets/images/closeButton_icon.svg';
  static const int int500 = 500;
  static const double doubleNag1 = -1;
  static const double double0 = 0;
  static const double double0_55 = 0.55;
  static const double double2_5 = 2.5;
  static const String closeButtonLabel = 'close';
}

class SendReportOverlayNotification {
  static OverlayEntry? _overlayEntry;
  //static Timer? _timer;
  static late SendReportOverlayNotificationAttributes _attributes;

  static void dismiss() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      //_timer?.cancel();
      _overlayEntry = null;
      //_timer = null;
    }
  }

  static void showCustomNotifcation(
    BuildContext context, {
    required SendReportOverlayNotificationAttributes attributes,
  }) async {
    _attributes = attributes;

    var overlayState = NavigationManager.navigatorKey.currentState?.overlay;
    dismiss();
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = PSTheme().themeFor(_Constants.sendReportApiErrorTheme);
        return Theme(
          data: theme,
          child: _OverlayNotificationBody(
            attributes: _attributes,
          ),
        );
      },
    );
    if(overlayState != null){
      overlayState.insert(_overlayEntry!);
      /* _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
        dismiss();
        _timer?.cancel();
      }); */
    }
  }
}

class _OverlayNotificationBody extends StatefulWidget {
  const _OverlayNotificationBody({
    required this.attributes,
    Key? key,
  }) : super(key: key);
  final SendReportOverlayNotificationAttributes attributes;

  @override
  State<_OverlayNotificationBody> createState() =>
      _OverlayNotificationBodyState();
}

class _OverlayNotificationBodyState extends State<_OverlayNotificationBody>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: _Constants.int500));
    offset = Tween<Offset>(
      begin: Offset(_Constants.double0,_Constants.doubleNag1),
      end: Offset(_Constants.double0, _Constants.double0_55),
    ).animate(controller);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.COLOR_TRANSPARENT,
      child: Container(
        color: ColorConstants.COLOR_FF524845_OPACITY_4,
        width: PSMediaQuery.screenWidth,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
              left: DimensionConstants.size20,
              right: DimensionConstants.size20,
              child: SlideTransition(
                position: offset,
                child: _buildNotificationBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBody() {
    final size = DimensionConstants.size60;
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.COLOR_WHITE,
        borderRadius: BorderRadius.all(
          Radius.circular(DimensionConstants.size10),
        ),
      ),
      child: Stack(
        children: [     
          Padding(
            padding: const EdgeInsets.only(
              left: DimensionConstants.size20,
              right: DimensionConstants.size33,
              top: DimensionConstants.size20,
              bottom: DimensionConstants.size20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size + DimensionConstants.size20,
                  child: _buildIcon(size),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PSText(
                        text: TextUIDataModel(
                          widget.attributes.title,
                          styleVariant: PSTextStyleVariant.headline4,
                        ),
                      ),
                      const SizedBox(height: DimensionConstants.size10,),
                       RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: widget.attributes.description.map((e) {
                            return TextSpan(text: e.text, style: e.style);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: DimensionConstants.size10,
            right: widget.attributes.isArabic ? null : DimensionConstants.size10,
            left: widget.attributes.isArabic ? DimensionConstants.size10 : null,
            child: Semantics(
              label: _Constants.closeButtonLabel,
              focusable: true,
              child: GestureDetector(
                onTap: () async {
                  await controller.reverse();
                  SendReportOverlayNotification.dismiss();
                },
                child: PSImage(
                  PSImageModel(
                    iconPath: _Constants.closeButtonIcon,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(double size) {
    return widget.attributes.iconType == NotificationIcon.checkMark
        ? PSImage(
            PSImageModel(
              iconPath: widget.attributes.iconType.getIcon,
            ),
          )
        : Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorConstants.COLOR_WHITE,
              border: Border.all(
                width: size / DimensionConstants.size8,
                color: widget.attributes.iconType == NotificationIcon.checkMark
                    ? PSTheme()
                        .themeFor(_Constants.sendReportApiErrorTheme)
                        .primaryColor
                    : PSTheme()
                        .themeFor(_Constants.sendReportApiErrorTheme)
                        .colorScheme.error,
              ),
              shape: BoxShape.circle,
            ),
            child: PSImage(
              PSImageModel(
                iconPath: widget.attributes.iconType.getIcon,
                width: size / _Constants.double2_5,
                height: size / _Constants.double2_5,
              ),
            ),
          );
  }
}
