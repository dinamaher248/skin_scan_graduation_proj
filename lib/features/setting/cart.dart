import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/constants.dart';

class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF34539D),
                    width: 0.w,
                  ),
                  borderRadius: BorderRadius.circular(0.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.w),
                  child: Image.asset(
                    'Images/cart.jpg',
                    width: 70.w,
                    height: 45.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              padding: EdgeInsets.all(2.h),
              margin: EdgeInsets.symmetric(horizontal: 2.h),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(15.w), 
              ),
              child: Center(
                child: Text(
                  'Success! ',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: PrimaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h), 
            Container(
              padding: EdgeInsets.all(0.w),
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: Center(
                child: Text(
                  'Your Process has  done successfully  ',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFAAA7A7),
                  ),
                ),
              ),
            ),

            SizedBox(height: 5.h),
            Container(
              padding: EdgeInsets.all(3.w), 
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: PrimaryColor, 
                borderRadius: BorderRadius.circular(30.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'continue',
                    style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
