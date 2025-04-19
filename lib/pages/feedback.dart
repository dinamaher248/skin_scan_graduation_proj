import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';

import '../Api/constants.dart';
import '../helper/token.dart';
import '../widgets/bar_pages_widget.dart';

class FeedbackPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  FeedbackPage({super.key});

  // Method to submit feedback
  Future<void> submitFeedback(
      BuildContext context, String subject, String feedback) async {
    final url = Uri.parse(resourceUrl + '/api/FeedBack/add');
    String? token = await Tokens.retrieve('access_token');

    final headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'Subject': subject,
      'FeedBackContent': feedback,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Feedback submitted successfully
        print('Feedback submitted successfully');
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        // Show success message and clear fields
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Feedback sent successfully!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the text fields
        subjectController.clear();
        feedbackController.clear();
      } else {
        // Handle other errors
        final errorRes = jsonDecode(response.body);
        print('Failed to submit feedback: ${errorRes['User']}');
      }
    } catch (error) {
      print('Error submitting feedback: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 6.h),

            BarPagesWidget(
              title: 'FeedBack',
            ),

            SizedBox(height: 2.h),

            // Feedback Form Container
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: subjectController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Subject',
                        hintStyle: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Feedback Input
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: feedbackController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Feedback........',
                        hintStyle: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Submit Button
                  GestureDetector(
                    onTap: () async {
                      final subject = subjectController.text;
                      final feedback = feedbackController.text;

                      // Call submitFeedback on tap
                      await submitFeedback(context, subject, feedback);
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.h),
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF34539D),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Center(
                      child: Text(
                        'If you have a technical question or are experiencing difficulty using the app, please let us know.\n'
                        'You can now access your program via web browser here.\n',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 84, 83, 83),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600, // Semi-bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


