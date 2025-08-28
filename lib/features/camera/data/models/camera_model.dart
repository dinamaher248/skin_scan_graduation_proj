import 'package:image_picker/image_picker.dart';

class CameraModel {
  final XFile? imageFile;

  CameraModel({this.imageFile});

  CameraModel copyWith({XFile? imageFile}) {
    return CameraModel(
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
