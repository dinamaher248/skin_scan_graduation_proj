import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/Mapping/mapping_upload.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../data/repo/result_repo.dart';
import '../view_models/result_cubit.dart';
import 'widgets/build_dropdown.dart';
import 'widgets/build_header.dart';
import 'widgets/build_image_preview.dart';
import 'widgets/build_result_container.dart';
import 'widgets/doctor_ask_widget.dart';

class ResultPage extends StatelessWidget {
  final String imagePath;

  const ResultPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResultCubit(ResultRepository()),
      child: BlocConsumer<ResultCubit, ResultState>(
        listener: (context, state) {
          if (state is ResultError) {
            customSnackBar(
              context,
              state.message,
              Colors.red,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ResultCubit>();

          MappingUpload? upload;
          if (state is ResultLoaded) upload = state.upload;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(context, cubit),
                  buildImagePreview(imagePath),
                  SizedBox(height: 2.h),
                  buildDropdown(context, cubit, imagePath),
                  SizedBox(height: 2.h),
                  if (state is ResultLoading)
                    Center(
                        child: LoadingAnimationWidget.inkDrop(
                      color: PrimaryColor,
                      size: 40,
                    ))
                  else if (upload != null)
                    buildResultContainer(upload, context)
                  else if (state is ResultError)
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Text(state.message,
                          style: TextStyle(color: Colors.red)),
                    ),
                  SizedBox(height: 2.h),
                  if (upload != null &&
                      upload.name != null &&
                      upload.Risk != null)
                    const DoctorAskWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
