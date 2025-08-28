import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MyThird_intro extends StatefulWidget {
  const MyThird_intro({super.key});

  @override
  State<MyThird_intro> createState() => _MyThird_introState();
}

class _MyThird_introState extends State<MyThird_intro> {
  @override
  void initState() {
    super.initState();
    // Delayed navigation
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF34539D),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'Images/photo_2024-08-11_12-46-29.jpg',
                  width: 15.w,
                  height: 10.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text('Skin Scan ',
              style: GoogleFonts.kavoon(
                color: Colors.white,
                fontSize: 23.sp,
                fontWeight: FontWeight.w400, //Regular
              )),
        ],
      ),
    );
  }
}
