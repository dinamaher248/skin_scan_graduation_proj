import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BarPagesWidget extends StatelessWidget {
    BarPagesWidget({required this.title});
  String? title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: IconButton(
            icon: Icon(
              Icons.arrow_circle_left_outlined,
              size: 25.sp,
              color: const Color(0xFF34539D),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.h),
          child: Text('$title',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600, //semi bold
              )),
        ),
      ],
    );
  }
}
