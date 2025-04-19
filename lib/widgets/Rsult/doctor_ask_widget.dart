import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorAskWidget extends StatelessWidget {
  const DoctorAskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/doctors');
      },
      child: Container(
                     // padding: EdgeInsets.all(2.w),
                      margin: EdgeInsets.symmetric(horizontal: 23.w), //23  //7.5
                      decoration: BoxDecoration(
                        color: const Color(0xFF6AFF72),
                        borderRadius: BorderRadius.circular(7.w),
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ask Doctor',
                              style: TextStyle(
                                fontSize: 16.sp, 
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF34539D),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.chat_rounded,
                                color: const Color(0xFF34539D),
                                size: 5.w,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/doctors');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
    );
  }
}