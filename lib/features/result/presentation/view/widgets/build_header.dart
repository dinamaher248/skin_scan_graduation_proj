
  import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../view_models/result_cubit.dart';

Widget buildHeader(BuildContext context, ResultCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w, top: 7.h),
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: Icon(
              Icons.close,
              size: 6.w,
              color: const Color(0xFF34539D),
            ),
          ),
        ),
        SizedBox(width: 25.w),
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Text('Result',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }
