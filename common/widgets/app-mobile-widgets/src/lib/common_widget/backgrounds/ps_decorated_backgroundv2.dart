import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/utils/icon_utils.dart';

/// Default decoration image uri for the background
const String _PSDecoratedBackgroundV2ChevronIconUri = 'widget_library:assets/images/bg_chevron.svg';

/// Rework of [PSDecoratedBackground] for a cleaner shading of image.
///
/// Container which facilitates decorating background of a screen
/// with any image and gradient
///
/// #### Example:
/// [YourCardsScreen] in app-account package
class PSDecoratedBackgroundV2 extends StatelessWidget {
  final Color? backgroundColor;
  final Color? backgroundGradientTopColor;
  final Color backgroundGradientBottomColor;
  final List<Color>? gradientColors;
  final String decorationIconUri;
  final Alignment? decorationIconAlignment;
  final ImageType imageType;
  final bool stretch;
  final Color? decorationColor;

  const PSDecoratedBackgroundV2({
    Key? key,
    this.backgroundColor,
    this.backgroundGradientTopColor,
    this.backgroundGradientBottomColor = Colors.transparent,
    this.gradientColors,
    this.decorationIconUri = _PSDecoratedBackgroundV2ChevronIconUri,
    this.decorationIconAlignment = Alignment.topCenter,
    this.imageType = ImageType.Svg,
    this.stretch = false,
    this.decorationColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('PSDecoratedBackgroundV2_Container'),
      color: backgroundColor ?? Colors.transparent,
      child: decorationIconAlignment == null
          ? _getImageContainer(context)
          : Align(
              key: Key('PSDecoratedBackgroundV2_Align'),
              alignment: decorationIconAlignment!,
              child: _getImageContainer(context),
            ),
    );
  }

  Widget _getImageContainer(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors == null
            ? [
                backgroundGradientTopColor!,
                backgroundGradientBottomColor,
              ]
            : gradientColors!,
      ).createShader(bounds),
      child: _getImage(context),
    );
  }

  Widget _getImage(BuildContext context) {
    return imageType == ImageType.Svg
        ? /* getSvg(
            decorationIconUri,
            color: decorationColor,
            boxFit: BoxFit.fitWidth,
            width: stretch ? MediaQuery.of(context).size.width : null,
          ) */
        PSImage(
            PSImageModel(
              iconPath: decorationIconUri,
              boxFit: BoxFit.fitWidth,
              width: stretch ? MediaQuery.of(context).size.width : null,
            ),
          )
        : /* getPng(
            decorationIconUri,
            color: decorationColor,
            width: MediaQuery.of(context).size.width,
          ) */
        PSImage(
            PSImageModel(
              iconPath: decorationIconUri,
              color: decorationColor,
              width: MediaQuery.of(context).size.width,
            ),
          );
  }
}
