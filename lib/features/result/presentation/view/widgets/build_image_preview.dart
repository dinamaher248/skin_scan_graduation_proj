
  import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

Widget buildImagePreview(final String imagePath) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF34539D), width: 2.w),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.file(
            File(imagePath),
            width: 60.w,
            height: 35.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
