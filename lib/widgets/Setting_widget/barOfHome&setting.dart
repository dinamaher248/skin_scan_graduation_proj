import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';
import '../../Api/constants.dart';
import '../../helper/Chat.dart';
import '../../helper/token.dart';
import '../../pages/doctors.dart';
import '../Rsult/doctor_ask_widget.dart';

class BarHomeSetting extends StatefulWidget {
  const BarHomeSetting({super.key});

  @override
  State<BarHomeSetting> createState() => _BarHomeSettingState();
}

class _BarHomeSettingState extends State<BarHomeSetting> {
  bool is_doctor = false;

  void initState() {
    super.initState();
    Is();
  }

  void Is() async {
    String ROLE = await Tokens.getRole(await Tokens.retrieve('access_token'));
    if (ROLE == "Doc") is_doctor = true;
  }

  // Asynchronous method to retrieve the user's name
  Future<String> _getUserName() async {
    return await Tokens.getName(await Tokens.retrieve('access_token'));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserName(), // Calling the async function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(
              child: LoadingAnimationWidget.inkDrop(
                    color: PrimaryColor,
                    size: 40,
                  )); 
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}')); // Handle error
        } else {
          final userName = snapshot.data ?? 'User'; // Default to 'User' if null
          return Column(
            children: [
              SizedBox(
                height: 6.h,
              ),
              // Photo user
              Row(
                children: [
                  SizedBox(
                    width: 7.w,
                  ),
                  if (is_doctor)
                    CircleAvatar(
                      radius: 5.w,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          const AssetImage('Images/profile_doctor.png'),
                    )
                  else
                    CircleAvatar(
                      radius: 7.w,
                      backgroundImage:
                          const AssetImage('Images/profile pic.png'),
                    ),
                  SizedBox(width: 6.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600, // Semi-bold
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 1.5.w,
                          ),
                          Text(
                            'Hi $userName..!',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF989898),
                              fontSize: 12.8.sp,
                              fontWeight: FontWeight.w500, // Medium
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Additional content
              SizedBox(height: 3.h),
              Text(
                'Skin Scan',
                style: GoogleFonts.inter(
                  color: const Color(0xFF142859),
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600, // Semi-bold
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
