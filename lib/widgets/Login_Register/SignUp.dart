import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class buildSignUp extends StatelessWidget {
  final String text;
  final String push;

  const buildSignUp({super.key, required this.text, required this.push});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/$push');
        },
        child: Text(text,
            style: TextStyle(
                color: const Color(0xFF34539D),
                fontSize: 15.sp,
                decoration: TextDecoration.underline)),
      ),
    );
  }
}
