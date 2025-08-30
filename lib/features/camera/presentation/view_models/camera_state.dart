import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraReady extends CameraState {
  final CameraController controller;
  final bool isFlashOn;
  final XFile? imageFile;

  CameraReady({
    required this.controller,
    this.isFlashOn = false,
    this.imageFile,
  });

  CameraReady copyWith({
    CameraController? controller,
    bool? isFlashOn,
    XFile? imageFile,
  }) {
    return CameraReady(
      controller: controller ?? this.controller,
      isFlashOn: isFlashOn ?? this.isFlashOn,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}

class CameraError extends CameraState {
  final String message;
  CameraError(this.message);
}
