import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGeneratorAttributes {
  // The (square) size of the image
  final double? qrSize;

  // Text data to the encoded
  final String qrData;

  // Adds an extra pixel in size to prevent gaps (default is true).
  final bool? gapLess;

  // `QrVersions.auto` or a value between 1 and 40.
  // See http://www.qrcode.com/en/about/version.html for limitations and details.
  final int? qrVersion;

  // Circular border radius beside the QR code
  final double? qrBorderRadius;

  // Will be used by screen readers to describe the content of the QR code.
  final String? semanticsLabel;

  // 	The background color (default is transparent).
  final Color? qrBackgroundColor;

  // Defines an image to be overlaid in the center of the QR code
  final ImageProvider? qrEmbeddedImage;

  // Properties to style the embedded image
  final QrEmbeddedImageStyle? qrEmbeddedImageStyle;

  QRCodeGeneratorAttributes(
      {required this.qrData,
      this.qrSize,
      this.gapLess,
      this.qrVersion,
      this.qrBorderRadius,
      this.semanticsLabel,
      this.qrBackgroundColor,
      this.qrEmbeddedImage,
      this.qrEmbeddedImageStyle});
}

class QRCodeGenerator extends StatelessWidget {
  const QRCodeGenerator({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final QRCodeGeneratorAttributes attributes;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(attributes.qrBorderRadius ?? 0),
      child: QrImageView(
        size: attributes.qrSize,
        data: attributes.qrData,
        gapless: attributes.gapLess ?? true,
        version: attributes.qrVersion ?? QrVersions.auto,
        semanticsLabel: attributes.semanticsLabel ?? '',
        backgroundColor: attributes.qrBackgroundColor ?? Colors.transparent,
        embeddedImage: attributes.qrEmbeddedImage,
        embeddedImageStyle: attributes.qrEmbeddedImageStyle ??
            QrEmbeddedImageStyle(
              size: Size(80, 80),
            ),
      ),
    );
  }
}
