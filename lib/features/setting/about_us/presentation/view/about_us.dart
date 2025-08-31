import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/about_us_widget.dart';
import '../../../../../core/widgets/bar_pages_widget.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarPagesWidget(
        title: 'About Us',
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'Images/photo_2024-08-11_12-36-43.jpg',
                      width: 81.w,
                      height: 51.h,
                    ),
                  ),

                  /// About Sections
                  AboutUsWidget(
                    subject: 'Skin Scan',
                    info:
                        'Bacterial skin infections occur when bacteria enter the skin, either from an outside source or because they are present on the skin. '
                        'They can enter through a hair follicle or after a wound. So we developed this program to identify skin infections and types of wounds.',
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
                        'Our vision is to lead the future of dermatological care by continuously integrating advanced technology and artificial intelligence '
                        'to offer accessible, accurate, and personalized skin health solutions. '
                        'We strive to be a global leader in dermatology, ensuring that everyone has the tools they need to diagnose and manage their skin health efficiently, '
                        'ultimately reducing skin disease burdens worldwide.',
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
