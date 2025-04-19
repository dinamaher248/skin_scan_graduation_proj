import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Mapping/map_doctor.dart';
import '../helper/token.dart';
import '../widgets/Setting_widget/barOfHome&setting.dart';
import '../widgets/Setting_widget/logout_widget.dart';
import '../widgets/Setting_widget/setting_content_widget.dart';

class Setting_page extends StatefulWidget {
  const Setting_page({super.key});

  @override
  State<Setting_page> createState() => _Setting_pageState();
}

class _Setting_pageState extends State<Setting_page> {
  bool is_doctor = false;
  void initState() {
    super.initState();
    Is();
  }

  void Is() async {
    String ROLE = await Tokens.getRole(await Tokens.retrieve('access_token'));
    setState(() {
      is_doctor = (ROLE == "Doc");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BarHomeSetting(),

            //####################################################
            //to content card
            SizedBox(height: 4.h),
            setting_content_widget(
                Content: 'About Us', icon: Icons.people, push: 'aboutUs'),
            SizedBox(height: 1.5.h),

            setting_content_widget(
              Content: 'Browse Disease',
              icon: Icons.health_and_safety,
              push: 'BrowseDisease',
            ),
            SizedBox(height: 1.5.h),

            setting_content_widget(
              Content: 'FeedBack',
              icon: Icons.feedback,
              push: 'feedback',
            ),
            //SizedBox(height: 1.5.h),

            // setting_content_widget(
            //   Content: 'Social',
            //   icon: Icons.social_distance,
            //   push: 'invite',
            // ),
            // SizedBox(height: 1.5.h),

            // setting_content_widget(
            //   Content: 'Visit Website',
            //   icon: Icons.severe_cold_sharp,
            //   push: '',
            // ),
            SizedBox(height: 1.5.h),
            //  if (is_doctor)
            // setting_content_widget(
            //   Content: 'Appointmets',
            //   icon: Icons.calendar_month,
            //   push: 'appointmentAll',
            // ),
            // SizedBox(height: 1.5.h),
            setting_content_widget(
              Content: 'Clincs',
              icon: Icons.calendar_month,
              push: 'clincs',
            ),
            SizedBox(height: 1.5.h),

            // else
            setting_content_widget(
              Content: 'Doctors',
              icon: Icons.medical_information,
              push: 'doctors',
            ),
            if (is_doctor) SizedBox(height: 1.5.h),
            if (is_doctor)
              setting_content_widget(
                Content: 'Users',
                icon: Icons.verified_user,
                push: 'users',
              ),
            SizedBox(height: 1.5.h),
            LogoutWidget(
              Content: 'log out',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
      //##########################################################
      //bottom
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/camera');
        },
        backgroundColor: const Color(0xFF34539D),
        child: const Icon(Icons.crop_free, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 6.w), // Reduced padding

        child: Padding(
          padding: EdgeInsets.all(1.0.h), // Reduced padding
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80.w),
            child: SizedBox(
              height: 7.8.h,
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 5.w,
                color: const Color(0xFF34539D),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.settings, color: Color(0xFF3FFF49)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
