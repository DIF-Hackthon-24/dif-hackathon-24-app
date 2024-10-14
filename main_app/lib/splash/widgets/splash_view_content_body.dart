import 'package:flutter/material.dart';
import 'package:theme_font/color/app_theme_colors.dart';
import 'package:widget_library/ps_scaffold.dart';
import 'force_upgrade.dart';

class _Constants {
  static const String themeName = 'splash';
}

class SplashViewContentBody extends StatefulWidget {
  final int failedImages;
  final int failedVideos;
  final double syncProgressValue;
  final bool noInternet;
  final bool showProgress;
  final bool hasConfigFetchFailed;
  final bool startAnimation;
  final bool syncApiFailed;
  final bool downloadFailed;
  final bool showDownloadFailedDetails;
  final String progressBarText;
  final bool isForceUpgradeRequired;
  final VoidCallback? onUpgradeNow;
  final ForceUpgradeContent forceUpgradeContent;
  final Function onRetryDownload;
  final Function onSkipAndContinue;
  final VoidCallback? onSkipPress;

  const SplashViewContentBody({
    required this.progressBarText,
    required this.syncProgressValue,
    required this.noInternet,
    required this.showProgress,
    required this.hasConfigFetchFailed,
    required this.syncApiFailed,
    required this.downloadFailed,
    required this.showDownloadFailedDetails,
    required this.startAnimation,

    required this.isForceUpgradeRequired,
    required this.forceUpgradeContent,

    required this.onRetryDownload,
    required this.onSkipAndContinue,

    required this.failedImages,
    required this.failedVideos,
    this.onUpgradeNow,
    this.onSkipPress,
    super.key,
  });

  @override
  State<SplashViewContentBody> createState() => _SplashViewContentBodyState();
}

class _SplashViewContentBodyState extends State<SplashViewContentBody> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PSScaffold(
      themeName: _Constants.themeName,
      body: Container(),
    );
  }
}

class WhiteLinearProgressIndicator extends StatelessWidget {
  final double value;

  const WhiteLinearProgressIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      key: const Key('data-qe-lbl_progress_bar'),
      value: value / 100,
      backgroundColor: AppThemeColors.brownChert.toColor,
      valueColor: AlwaysStoppedAnimation<Color>(
        AppThemeColors.sandstone25.toColor,
      ),
    );
  }
}
