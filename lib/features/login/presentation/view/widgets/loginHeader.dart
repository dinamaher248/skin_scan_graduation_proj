import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget LoginHeader(final String text) {
  return Padding(
    padding: EdgeInsets.only(left: 6.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(text,
            style: GoogleFonts.inter(
                fontSize: 16.8.sp, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
