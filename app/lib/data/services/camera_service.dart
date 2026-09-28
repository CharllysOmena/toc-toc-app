import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

abstract class CameraService {
  Future<void> initialize();
  Widget buildPreview();
  Future<XFile?> takePicture();
  Future<void> dispose();
}

class CameraServiceImpl implements CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  @override
  Future<void> initialize() async {
    _cameras = await availableCameras();
    if (_cameras == null || _cameras!.isEmpty) {
      throw Exception('Nenhuma câmera disponível');
    }
    _controller = CameraController(_cameras!.first, ResolutionPreset.high, enableAudio: false);
    await _controller!.initialize();
  }

  @override
  Widget buildPreview() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return CameraPreview(controller);
  }

  @override
  Future<XFile?> takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return null;
    return controller.takePicture();
  }

  @override
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }
}
