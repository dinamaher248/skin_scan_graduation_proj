import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Loginbutton extends StatelessWidget {
  final String button;
  final VoidCallback onPressed;
  const Loginbutton({
    Key? key,
    required this.button,
    required this.onPressed,
  }) : super(key: key);

  //  final TextEditingController _emailController = TextEditingController();

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // void resetPassword() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     // Handle password reset logic here
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content:
  //               Text('Password reset link sent to ${_emailController.text}')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 3.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF34539D),
            minimumSize: Size(80.w, 5.h)),
        onPressed: onPressed,
        child: Text(
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
