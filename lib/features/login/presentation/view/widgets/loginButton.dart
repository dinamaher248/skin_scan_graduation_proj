import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/constants.dart';

class Loginbutton extends StatelessWidget {
  final String button;
  final VoidCallback onPressed;
  final bool isloading;

  const Loginbutton({
    super.key,
    required this.button,
    required this.onPressed,
    this.isloading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 2.5.h),
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
