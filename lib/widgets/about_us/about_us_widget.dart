import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AboutUsWidget extends StatelessWidget {
  String? info;
    String? subject;
  AboutUsWidget({required this.subject, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.h), // حول اطار حول
      margin: EdgeInsets.symmetric(
          horizontal: 2.h), //علشان اعمل مسافه من اليمين و الشمال
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 192, 208, 253),
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('$subject',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600, //semi bold
                )),
          ),
          SizedBox(height: 1.5.h), // المسافة بين skin scan والنص
          Center(
            child: Text('$info',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400, //semi bold
                )),
          ),
        ],
      ),
    );
  }
}
