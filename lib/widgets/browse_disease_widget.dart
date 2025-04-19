import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BrowseDiseaseWidget extends StatelessWidget {
  String bacteraia_text_bar;
  String Description_text;
  String Prevention_text;
  BrowseDiseaseWidget(
      {super.key,
      required this.bacteraia_text_bar,
      required this.Description_text,
      required this.Prevention_text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2.h, top: 13.w),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 10.w,
                  color: const Color(0xFF34539D),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Padding(
              padding: EdgeInsets.only(top: 13.w),
              child: Text(
                bacteraia_text_bar,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 4.w),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: const Color(0xFF34539D),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Container(
          padding: EdgeInsets.all(2.h),
          margin: EdgeInsets.symmetric(horizontal: 3.h),
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 208, 219, 249), 
            borderRadius: BorderRadius.circular(3.h),
          ),
          child: Center(
            child: Text(
              Description_text,
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 3.5.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 5.w),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: const Color(0xFF34539D),
                borderRadius: BorderRadius.circular(4.5.w),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'First aid',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Container(
          padding: EdgeInsets.all(2.h),
          margin: EdgeInsets.symmetric(horizontal: 3.h),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 208, 219, 249),
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Center(
            child: Text(
              Prevention_text,
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
