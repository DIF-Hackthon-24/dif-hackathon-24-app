import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/dimension_constants.dart';
import 'package:theme_font/theme_font.dart';
class ForceUpgrade extends StatelessWidget {
  final VoidCallback? onUpgradeNow;
  final VoidCallback? onSkipPress;
  final ForceUpgradeContent forceUpgradeContent;
  const ForceUpgrade({
    super.key,this.onSkipPress,
    this.onUpgradeNow, required this. forceUpgradeContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: forceUpgradeContent.forceUpgradeTitle.isEmpty?DimensionConstants.size250:DimensionConstants.size400,
      width: DimensionConstants.size600,
      color: AppThemeColors.sandstone25.toColor,
      child: Padding(
        padding: const EdgeInsets.only(
            left: DimensionConstants.size100,
            right: DimensionConstants.size100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           if(forceUpgradeContent.forceUpgradeTitle.isNotEmpty) Text(
              forceUpgradeContent.forceUpgradeTitle,
              style: AppFontStyle.style(
                typography: FontTypography.heading3Medium,
                color: AppThemeColors.brownChert,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              forceUpgradeContent.forceUpgradeDescription,
              style: AppFontStyle.style(
                typography: FontTypography.body01Medium,
                color: AppThemeColors.brownChert,
              ),
            ),
            const SizedBox(
              height: DimensionConstants.size40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10,),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ForceUpgradeContent {
  final String forceUpgradeLabel;
  final String forceUpdateSkipLabel;
  final String forceUpgradeTitle;
  final String forceUpgradeDescription;

  ForceUpgradeContent(
      {required this.forceUpgradeTitle,
      required this.forceUpgradeDescription,
      required this.forceUpgradeLabel,
        required this.forceUpdateSkipLabel});
}