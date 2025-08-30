import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/constants.dart';
import '../../../result/presentation/view/result_photo.dart';
import '../view_models/camera_cubit.dart';
import '../view_models/camera_state.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> myCameras;

  const CameraPage({super.key, required this.myCameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CameraCubit(cameras: widget.myCameras)..initCamera(),
      child: BlocBuilder<CameraCubit, CameraState>(
        builder: (context, state) {
          if (state is CameraLoading || state is CameraInitial) {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: PrimaryColor,
                  size: 40,
                ),
              ),
            );
          }

          if (state is CameraError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }

          if (state is CameraReady) {
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  children: <Widget>[
                    Positioned.fill(child: CameraPreview(state.controller)),

                    // Back Button
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_circle_left_outlined,
                            size: 22.3.sp,
                            color: const Color(0xFF34539D),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    // Title
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Text(
                          'Scanning Skin',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Buttons
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              heroTag: 'photoLibrary',
                              onPressed: () async {
                                final pickedFile = await context
                                    .read<CameraCubit>()
                                    .pickImageFromGallery();
                                if (pickedFile != null && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultPage(imagePath: pickedFile.path),
                                    ),
                                  );
                                }
                              },
                              backgroundColor: Colors.white,
                              child: const Icon(Icons.photo_library),
                            ),
                            SizedBox(width: 20.w),
                            FloatingActionButton(
                              heroTag: 'takePicture',
                              onPressed: () async {
                                final picture = await context
                                    .read<CameraCubit>()
                                    .takePicture();
                                if (picture != null && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultPage(imagePath: picture.path),
                                    ),
                                  );
                                }
                              },
                              backgroundColor: Colors.white,
                              child: const Icon(Icons.crop_free),
                            ),
                            SizedBox(width: 20.w),
                            FloatingActionButton(
                              heroTag: 'flash',
                              onPressed: () =>
                                  context.read<CameraCubit>().toggleFlash(),
                              backgroundColor: Colors.white,
                              child: Icon(state.isFlashOn
                                  ? Icons.flash_on
                                  : Icons.flash_off),
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

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
