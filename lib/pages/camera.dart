import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';

import '../Api/constants.dart';
import 'result_photo.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> myCameras;

  const CameraPage({required this.myCameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? imageFile;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.myCameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return  Scaffold(
        body: Center(
          child: LoadingAnimationWidget.inkDrop(
                    color: PrimaryColor,
                    size: 40,
                  ),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: CameraPreview(controller)),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon:  Icon(
                    Icons.arrow_circle_left_outlined,
                    size:  22.3.sp,
                    color: Color(0xFF34539D),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Text(
                  'Scanning Skin',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'photoLibrary',
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.photo_library),
                    ),
                    SizedBox(width: 20.w),
                    FloatingActionButton(
                      heroTag: 'takePicture',
                      onPressed: () {
                        _takePicture();
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.crop_free),
                    ),
                    SizedBox(width: 20.w),
                    FloatingActionButton(
                      heroTag: 'flash',
                      onPressed: () {
                        setState(() {
                          _isFlashOn = !_isFlashOn;
                          controller.setFlashMode(
                              _isFlashOn ? FlashMode.torch : FlashMode.off);
                        });
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to take a picture using the camera
  void _takePicture() async {
    try {
      final XFile picture = await controller.takePicture();
      setState(() {
        imageFile = picture;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(imagePath: imageFile!.path),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error taking picture: $e")),
      );
    }
  }

  // Method to pick an image from the gallery
  void _pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Result(imagePath: imageFile!.path),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }
}
