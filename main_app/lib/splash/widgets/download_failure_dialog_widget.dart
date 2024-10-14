import 'package:flutter/material.dart';
import 'package:theme_font/color/app_theme_colors.dart';
import 'package:theme_font/font/app_font_style.dart';

class DownloadFailureDialogWidgetAttribute {
  final String? dialogHeading;
  final String? headingColumn1;
  final String? headingColumn2;
  final String? skipButtonLabel;
  final String? retryButtonLabel;
  final String? numOfFailedVideoLabel;
  final String? numOfFailedImageLabel;

  DownloadFailureDialogWidgetAttribute({
    this.dialogHeading,
    this.headingColumn1,
    this.headingColumn2,
    this.retryButtonLabel,
    this.skipButtonLabel,
    this.numOfFailedVideoLabel,
    this.numOfFailedImageLabel,
  });
}

class DownloadFailureDialogWidget extends StatelessWidget {
  final int failedImages;
  final int failedVideos;
  final Function onRetry;
  final Function onSkipAndContinue;
  final DownloadFailureDialogWidgetAttribute attribute;

  const DownloadFailureDialogWidget({
    super.key,
    required this.attribute,
    required this.failedVideos,
    required this.failedImages,
    required this.onRetry,
    required this.onSkipAndContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppThemeColors.sandstone100.toColor,
      margin: const EdgeInsets.all(100),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              attribute.dialogHeading ?? '',
              style: AppFontStyle.style(
                typography: FontTypography.heading5Medium,
                color: AppThemeColors.charcoal,
              ),
              textAlign: TextAlign.start,
            ),
            if (failedImages>0)
              Text(
                '${attribute.numOfFailedImageLabel} $failedImages',
                style: AppFontStyle.style(
                  typography: FontTypography.heading6Light,
                  color: AppThemeColors.charcoal,
                ),
                textAlign: TextAlign.end,
              ),
            if (failedVideos>0)
              Text(
                '${attribute.numOfFailedVideoLabel} $failedVideos',
                style: AppFontStyle.style(
                  typography: FontTypography.heading6Light,
                  color: AppThemeColors.charcoal,
                ),
                textAlign: TextAlign.end,
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  // Header
                  Container(
                    color: AppThemeColors.charcoal.toColor,
                    child: Row(
                      children: [
                        _buildHeaderCell(attribute.headingColumn1 ?? '',
                            flex: 5),
                        _buildHeaderCell(attribute.headingColumn2 ?? '',
                            flex: 5),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: []
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: AppFontStyle.style(
            typography: FontTypography.button1Bold,
            color: AppThemeColors.white,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget _buildCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppThemeColors.charcoal.toColor),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: AppFontStyle.style(
            typography: FontTypography.body03Medium,
            color: AppThemeColors.charcoal,
          ),
        ),
      ),
    );
  }
}
