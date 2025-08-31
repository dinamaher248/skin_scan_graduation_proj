import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../features/home/presentation/view/Home.dart';
import '../utils/constants.dart';

class BarPagesWidget extends StatelessWidget implements PreferredSizeWidget {
  const BarPagesWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 22.7.sp,
            color: PrimaryColor,
          ),
          onPressed: () {
            if (title == 'Doctor List') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 17.6.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(8.h);
}
