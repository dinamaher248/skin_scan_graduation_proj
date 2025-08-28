import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MySecond_intro extends StatelessWidget {
  const MySecond_intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('Images/photo_2024-08-11_12-36-43.jpg'),
              width: 60.w,
              height: 50.h,
            ),
            Text('Welcome To Skin App! ',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500, //semi bold
                )),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 0.w),
              child: Center(
                child: Text(
                    'Analyse your skin condition and receive instant results and recommendations',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5B5B5B),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400, //semi bold
                    )),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 1.2.w,
                  backgroundColor: const Color(0xFF34539D),
                ),
                SizedBox(
                  width: 3.w,
                ),
                CircleAvatar(
                  radius: 1.2.w,
                  backgroundColor: const Color(0xFF34539D),
                ),
                SizedBox(width: 3.w),
                CircleAvatar(
                  radius: 1.2.w,
                  backgroundColor: const Color(0xFF9CB8FF),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // Padding(
            //   padding: EdgeInsets.only(right: 7.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: const Color(0xFF34539D),
            //               minimumSize: Size(30.w, 8.h)),
            //           onPressed: () {
            //             Navigator.pushNamed(context, '/third');
            //           },
            //           child: Text(
            //             'Next',
            //             style: TextStyle(
            //               fontSize: 18.sp,
            //               color: Colors.white,
            //             ),
            //           )),
            //     ],
            //   ),
            // ),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 6.h,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/third');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: const Color(0xFF4A6CBF),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 5.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
           SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
