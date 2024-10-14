import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PSImageModel {
  final String iconPath;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final AlignmentGeometry? alignment;
  final Animation<double>? opacity;

  PSImageModel({
    required this.iconPath,
    this.width,
    this.padding = const EdgeInsets.all(0),
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
    this.opacity,
  });
}

class PSImage extends StatelessWidget {
  final PSImageModel psImageModel;
  final Animation<double>? opacity;
  final Key? key;

  const PSImage(
    this.psImageModel, {
    this.opacity,
    this.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: psImageModel.padding,
        child: _Image(
          key: key,
          psImageModel.iconPath,
          width: psImageModel.width,
          height: psImageModel.height,
          color: psImageModel.color,
          boxFit: psImageModel.boxFit,
          alignment: psImageModel.alignment,
          opacity: psImageModel.opacity,
        ),
      );
}

class _Image extends StatelessWidget {
  final String iconPath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final AlignmentGeometry? alignment;
  final Animation<double>? opacity;

  const _Image(
    this.iconPath, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
    this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = iconPath.split(':');
    return _isPng
        ? Image.asset(
            list.length > 1 ? list[1] : list[0],
            package: list.length > 1 ? list[0] : null,
            height: height,
            width: width,
            fit: boxFit ?? BoxFit.fill,
            opacity: opacity,
          )
        : SvgPicture.asset(
            list.length > 1 ? list[1] : list[0],
            package: list.length > 1 ? list[0] : null,
            width: width,
            height: height,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            alignment: alignment ?? Alignment.center,
            fit: boxFit ?? BoxFit.contain,
          );
  }

  bool get _isPng => iconPath.contains('.png');
}
