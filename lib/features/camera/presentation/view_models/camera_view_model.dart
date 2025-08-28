import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/camera_model.dart';

class CameraViewModel extends ChangeNotifier {
  final List<CameraDescription> cameras;
  late CameraController controller;
  CameraModel _state = CameraModel();
  bool _isFlashOn = false;

  CameraModel get state => _state;
  bool get isFlashOn => _isFlashOn;

  CameraViewModel({required this.cameras});

  Future<void> initCamera() async {
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();
    notifyListeners();
  }

  void toggleFlash() {
    _isFlashOn = !_isFlashOn;
    controller.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    notifyListeners();
  }

  Future<XFile?> takePicture() async {
    try {
      final picture = await controller.takePicture();
      _state = _state.copyWith(imageFile: picture);
      notifyListeners();
      return picture;
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _state = _state.copyWith(imageFile: pickedFile);
        notifyListeners();
      }
      return pickedFile;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
