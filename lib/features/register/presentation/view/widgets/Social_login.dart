import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget SocialLoginButtons() {
  return Column(
    children: [
      Text(
        'Or Continue With',
        style: GoogleFonts.inter(
          color: const Color(0xFF34539D),
          fontSize: 14.7.sp,
          fontWeight: FontWeight.w600, //semibold
        ),
      ),
      SizedBox(height: 7.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Image.network(
                'http://pngimg.com/uploads/google/google_PNG19635.png',
                width: 11.w,
                height: 5.h),
            onPressed: () {},
          ),
          SizedBox(width: 7.w),
          IconButton(
            icon: Icon(Icons.facebook,
                size: 10.w, color: const Color(0xFF34539D)),
            onPressed: () {},
          ),
          SizedBox(width: 7.w),
          IconButton(
            icon: Icon(FontAwesomeIcons.twitter,
                size: 10.w, color: const Color(0xFF03A9F4)),
            onPressed: () {},
          ),
        ],
      ),
    ],
  );
}
