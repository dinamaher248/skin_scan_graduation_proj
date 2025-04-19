import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../Api/constants.dart';

class Loginbutton extends StatelessWidget {
  final String button;
  final VoidCallback onPressed;
  final bool isloading;

  const Loginbutton({
    Key? key,
    required this.button,
    required this.onPressed,
    this.isloading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 3.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: isloading
                ? PrimaryColor.withValues(alpha: 0.5)
                : PrimaryColor,
            minimumSize: Size(80.w, 5.h)),
        onPressed: onPressed,
        child: isloading
            ? LoadingAnimationWidget.threeArchedCircle(
                color: Colors.white,
                size: 30,
              )
            : Text(
                button,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.8.sp,
                    fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
