import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScannerAttributes {
  // The callback function to process the scanned QR code
  final Function(BarcodeCapture value) onQrDetect;

  // The scan window rectangle for the barcode scanner
  final Rect? qrScanWindow;

  // The detection speed for the scanner.
  final DetectionSpeed? qrDetectionSpeed;

  // Whether scanned barcodes should contain the image that is embedded into the barcode
  final bool? isQrReturnImage;

  // Whether the flashlight should be turned on when the camera is started
  final bool? isCameraTorchEnabled;

  QRCodeScannerAttributes({
    required this.onQrDetect,
    this.qrScanWindow,
    this.qrDetectionSpeed,
    this.isQrReturnImage,
    this.isCameraTorchEnabled,
  });
}

class QRCodeScanner extends StatefulWidget {
  final QRCodeScannerAttributes attributes;
  const QRCodeScanner({super.key, required this.attributes});

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  late MobileScannerController _controller;

  @override
  void initState() {
    _controller = MobileScannerController(
        detectionSpeed:
            widget.attributes.qrDetectionSpeed ?? DetectionSpeed.noDuplicates,
        returnImage: widget.attributes.isQrReturnImage ?? false,
        torchEnabled: widget.attributes.isCameraTorchEnabled ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MobileScanner(
        controller: _controller,
        scanWindow: widget.attributes.qrScanWindow,
        onDetect: (capture) => widget.attributes.onQrDetect(capture)
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _controller.dispose();
  }
}
