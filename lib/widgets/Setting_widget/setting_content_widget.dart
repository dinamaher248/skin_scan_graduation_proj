import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../helper/Chat.dart';

class setting_content_widget extends StatelessWidget {
  setting_content_widget({
    this.Content,
    this.icon,
    this.push,
  });
  String? Content;
  String? push;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/$push');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.w),
            ),
            color: const Color.fromARGB(255, 231, 235, 250),
            child: Row(
              children: [
                Flexible(
                  child: ListTile(
                    leading: Icon(
                      icon,
                      size: 17.sp,
                      color: const Color(0xFF34539D),
                    ),
                    title: Text(
                      '$Content',
                      style: GoogleFonts.inter(
                        fontSize: 16.5.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600, //semi bold
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/$push');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(1.5.w),
                      backgroundColor: const Color(0xFF4A6CBF),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
