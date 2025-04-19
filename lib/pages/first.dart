import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Skin_Scan_App extends StatelessWidget {
  const Skin_Scan_App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('Images/image.png'),
              width: 60.w,
              height: 50.h,
            ),
            //####################################
            Text('Welcome To Skin App! ',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500, //semi bold
                )),
            //#####################################
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 1.w),
              child: Center(
                child: Text(
                    ' Our goal is to make you feel confident about your health Skin',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5B5B5B),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400, //semi bold
                    )),
              ),
            ),
            //########################################
            SizedBox(height: 10.h),
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
                  backgroundColor: const Color(0xFF9CB8FF),
                ),
                SizedBox(width: 3.w),
                CircleAvatar(
                  radius: 1.2.w,
                  backgroundColor: const Color(0xFF9CB8FF),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 6.h,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/second');
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
