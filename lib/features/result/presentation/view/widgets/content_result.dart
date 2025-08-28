import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ContentResult extends StatelessWidget {
  const ContentResult({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: Text(label,
              style: GoogleFonts.inter(
                color: const Color(0xFF34539D),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600, // medium
              )),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Padding(
            padding:  EdgeInsets.only(top: 0.5.h),
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.7.sp,
                fontWeight: FontWeight.w400, // medium
              ),
            ),
          ),
        ),
      ],
    );
  }
}
