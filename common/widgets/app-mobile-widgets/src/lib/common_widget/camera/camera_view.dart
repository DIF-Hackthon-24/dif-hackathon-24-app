import 'package:camera/camera.dart';
import 'package:core/logging/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_library/common_widget/camera/camera_controller.dart';

/// Simple wrapper around the camera library preview widget.
/// Defaults to use the first available camera which by convention is the rear camera.
class PSCameraWidget extends StatefulWidget {
  final PSCameraController controller;

  PSCameraWidget(this.controller);

  @override
  State<StatefulWidget> createState() => _PSCameraWidgetState();
}

class _PSCameraWidgetState extends State<PSCameraWidget> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (_controller != null) {
      await _controller?.dispose();
    }
    if (cameras.isEmpty) {
      // No cameras
      PSLogger.logError('No cameras are available on the device');
      return;
    }

    _controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
      enableAudio: false,
    );

    _controller?.addListener(() {
      setState(() {});
    });

    try {
      await _controller?.initialize();
      await _controller?.setFlashMode(FlashMode.off);
      // expose the new controller to controller interface
      widget.controller.controller = _controller!;
    } on CameraException catch (e) {
      PSLogger.logError('Camera initialisation exception $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller?.value.isInitialized == true ? CameraPreview(_controller!) : Container();
  }
}
