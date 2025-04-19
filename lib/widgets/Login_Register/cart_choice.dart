import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Api/constants.dart';

  void showCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Register as a",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // خيار الدكتور
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/doctorDetails');
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 9.w,
                            backgroundColor: PrimaryColor,
                            backgroundImage:
                                AssetImage('Images/Online Doctor-rafiki.png'),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Doctor",
                            style: TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 9.w,
                            backgroundColor: PrimaryColor,
                            backgroundImage:
                                AssetImage('Images/patient_wound1.png'),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Patient",
                            style: TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
