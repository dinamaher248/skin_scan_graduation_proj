import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../widgets/about_us/about_us_widget.dart';
import '../widgets/bar_pages_widget.dart';

class about_us extends StatelessWidget {
  const about_us({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // دي اللي هتخليني اعمل scrol
        child: Column(
          children: [
            SizedBox(height: 7.h),
            BarPagesWidget(title: 'About Us',
              
            ),
            
            Align(
              alignment: Alignment.center, //الصوره في المنتصف
              child: Image.asset(
                'Images/photo_2024-08-11_12-36-43.jpg',
                width: 81.w,
                height: 51.h,
              ),
            ),
            AboutUsWidget(
              subject: 'Skin Scan',
              info:
              'Bacterial skin infections occur when bacteria enter the skin , either from an outside source or because they are'
              'present on the skin.They can enter the skin through a hair follicle or after a wound.So we developed this program to identify skin infections and types of wounds.',
            ),
            SizedBox(height: 2.h),
            AboutUsWidget(
              subject: 'Our Mission',
              info:
                  'Our mission is to leverage cutting-edge technology to make dermatological care accessible and efficient for everyone. '
                    'We aim to empower individuals with tools that can provide early and accurate diagnosis of skin conditions, ultimately improving health outcomes.',
                    ),
            
            SizedBox(height: 2.h),
              AboutUsWidget(
              subject: 'Our Vision',
              info:
      'Our vision is to lead the future of dermatological care by continuously integrating advanced technology and artificial intelligence to offer accessible, accurate, and personalized skin health solutions. '
      'We strive to be a global leader in dermatology, ensuring that everyone has the tools they need to diagnose and manage their skin health efficiently, ultimately reducing skin disease burdens worldwide.',
            ),
            SizedBox(height: 4.h),
          ], //Children1
        ),
      ),
    );
  }
}
