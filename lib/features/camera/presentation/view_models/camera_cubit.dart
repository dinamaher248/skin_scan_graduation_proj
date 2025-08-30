import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  final List<CameraDescription> cameras;
  late CameraController controller;

  CameraCubit({required this.cameras}) : super(CameraInitial());

  Future<void> initCamera() async {
    emit(CameraLoading());
    try {
      controller = CameraController(cameras[0], ResolutionPreset.high);
      await controller.initialize();
      emit(CameraReady(controller: controller));
    } catch (e) {
      emit(CameraError("Error initializing camera: $e"));
    }
  }

  void toggleFlash() {
    if (state is CameraReady) {
      final current = state as CameraReady;
      final newFlash = !current.isFlashOn;
      controller.setFlashMode(newFlash ? FlashMode.torch : FlashMode.off);
      emit(current.copyWith(isFlashOn: newFlash));
    }
  }

  Future<XFile?> takePicture() async {
    if (state is CameraReady) {
      try {
        final current = state as CameraReady;
        final picture = await controller.takePicture();
        final updated = current.copyWith(imageFile: picture);
        emit(updated);
        return picture;
      } catch (e) {
        emit(CameraError("Error taking picture: $e"));
      }
    }
    return null;
  }

  Future<XFile?> pickImageFromGallery() async {
    if (state is CameraReady) {
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          final current = state as CameraReady;
          final updated = current.copyWith(imageFile: pickedFile);
          emit(updated);
        }
        return pickedFile;
      } catch (e) {
        emit(CameraError("Error picking image: $e"));
      }
    }
    return null;
  }

 @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
