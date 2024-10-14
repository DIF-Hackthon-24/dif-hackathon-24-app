import 'package:camera/camera.dart';
import 'package:core/logging/logger.dart';

class PSCameraController {
  CameraController? _controller;

  set controller(CameraController controller) => _controller = controller;

  Future<String?> takePicture() async {
    if (!(_controller?.value.isInitialized == true)) {
      PSLogger.logError('No camera selected and initialised');
      return null;
    }

    if (_controller?.value.isTakingPicture == true) {
      // A capture is already pending, do nothing.
      PSLogger.logInfo('The camera is already taking a picture');
      return null;
    }

    String? filePath;

    try {
      final file = await _controller?.takePicture();
      filePath = file?.path;
    } on CameraException catch (e) {
      PSLogger.logError('Exception taking picture $e');
    }
    return filePath;
  }

  Future<void> toggleFlashMode() async {
    final flashMode = _controller?.value.flashMode;
    await _controller?.setFlashMode(flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off);
  }

  bool get isFlashOn => _controller?.value.flashMode == FlashMode.torch;
}
