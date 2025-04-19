import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../widgets/invite_widget.dart';

class Invite extends StatelessWidget {
  const Invite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 2.h),
              //icon left
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 22.3.sp,
                        color: const Color(0xFF34539D),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text('Invitation',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w600, //semi bold
                        )),
                  ),
                ],
              ),

              //to content card
              SizedBox(height: 3.h),
              InviteWidget(Content: 'user1'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user2'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user3'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user4'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user5'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user6'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user7'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user8'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user9'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user10'), SizedBox(height: 3.h),
              InviteWidget(Content: 'user11'), SizedBox(height: 3.h),
            ],
          ),
        ],
      ),

      //##########################################################
    );
  }
}
