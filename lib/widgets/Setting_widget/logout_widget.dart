import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../helper/token.dart';

class LogoutWidget extends StatelessWidget {
  LogoutWidget({this.Content, this.icon});
  String? Content;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.h),
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
                  onPressed: () async {
                    await Tokens.logout();
                    Navigator.pushNamed(context, '/');

                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding:  EdgeInsets.all(1.5.w),
                    backgroundColor: const Color(0xFF4A6CBF),
                  ),
                  child:  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
