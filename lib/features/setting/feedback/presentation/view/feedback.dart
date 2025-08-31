import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/bar_pages_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../data/models/feedback_model.dart';
import '../view_models/feedback_cubit.dart';

class FeedbackPage extends StatelessWidget {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedbackCubit(),
      child: Scaffold(
        appBar: const BarPagesWidget(title: 'FeedBack'),
        backgroundColor: Colors.white,
        body: BlocConsumer<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state is FeedbackSuccess) {
              customSnackBar(
                context,
                "Feedback sent successfully!",
                Colors.green,
              );

              subjectController.clear();
              feedbackController.clear();
            } else if (state is FeedbackError) {
              customSnackBar(
                context,
                state.message,
                Colors.red,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<FeedbackCubit>();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please write your feedback',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.h),

                        // Subject Input
                        _buildInputField(subjectController, 'Subject'),
                        SizedBox(height: 2.h),

                        // Feedback Input
                        _buildInputField(feedbackController, 'Feedback........',
                            maxLines: 6),
                        SizedBox(height: 4.h),

                        GestureDetector(
                          onTap: state is FeedbackLoading
                              ? null
                              : () {
                                  final subject = subjectController.text.trim();
                                  final feedback =
                                      feedbackController.text.trim();

                                  if (subject.isEmpty || feedback.isEmpty) {
                                    customSnackBar(
                                      context,
                                      "Please fill in all fields before submitting.",
                                      Colors.red,
                                    );
                                    return;
                                  }

                                  final model = FeedbackModel(
                                    subject: subject,
                                    feedback: feedback,
                                  );

                                  cubit.submitFeedback(model);
                                },
                          child: Container(
                            padding: EdgeInsets.all(2.h),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: BoxDecoration(
                              color: state is FeedbackLoading
                                  ? PrimaryColor.withValues(alpha: 0.5)
                                  : PrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is FeedbackLoading)
                                  LoadingAnimationWidget.threeArchedCircle(
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                if (state is! FeedbackLoading)
                                  Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // Technical Info Text
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          child: Center(
                            child: Text(
                              'If you have a technical question or are experiencing difficulty using the app, please let us know.\n'
                              'You can now access your program via web browser here.\n',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 84, 83, 83),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14.sp),
        ),
      ),
    );
  }
}
