import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'custom_text.dart';

void customSnackBar(context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      duration: const Duration(
        milliseconds: 3000,
      ),
      elevation: 5,
      clipBehavior: Clip.none,
      dismissDirection: DismissDirection.endToStart,
      content: Center(
          child: CustomText(
        text: text,
        color: Colors.white,
        textAlign: TextAlign.center,
        fontSize: 16.sp,
      )),
    ),
  );
}
