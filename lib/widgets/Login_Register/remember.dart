import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'resete_password.dart';

class buildRememberMeRow extends StatefulWidget {
  const buildRememberMeRow({super.key});

  @override
  State<buildRememberMeRow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<buildRememberMeRow> {
  bool? rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3.w),
          child: Checkbox(
              value: rememberMe,
              checkColor: Colors.white,
              activeColor: const Color(0xFF34539D),
              onChanged: (bool? value) {
                setState(() {
                  rememberMe = value;
                });
              }),
        ),
        Text('Remember me',
            style: GoogleFonts.inter(
                color: const Color(0xFF34539D), fontSize: 14.4.sp)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 3.w),
          child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                );
              },
              child: Text('Forgot password?',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF34539D),
                      fontSize: 14.4.sp,
                      decoration: TextDecoration.underline))),
        ),
      ],
    );
  }
}
