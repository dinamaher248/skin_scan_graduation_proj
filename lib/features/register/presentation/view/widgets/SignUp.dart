import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/constants.dart';

class buildSignUp extends StatelessWidget {
  final String text;
  final String push;
  final String underlineText;

  const buildSignUp(
      {super.key,
      required this.text,
      required this.underlineText,
      required this.push});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: PrimaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/$push');
            },
            child: Text(
              underlineText,
              style: TextStyle(
                color: PrimaryColor,
                fontSize: 15.sp,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
