import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../widgets/Login_Register/email&password_widget.dart';

class User_Info extends StatelessWidget {
  const User_Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //icon left
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.5.w),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 22.3.sp,
                    color: Color(0xFF34539D),
                  ),
                  onPressed: () {
                      Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          //###################################################
          SizedBox(height: 3.h),
          //photo user
          CircleAvatar(
            radius: 9.w,
            backgroundImage: AssetImage('Images/profile pic.png'),
          ),
          Text('User Name',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 17.5.sp,
                fontWeight: FontWeight.w600, //semi bold
              )),
          Text('Hi User!',
              style: GoogleFonts.inter(
                color: const Color(0xFF989898),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500, //medium
              )),
          //####################################################
          SizedBox(height: 5.h),
          //card that recorded
          SizedBox(
            height: 6.6.h,
            width: 86.5.w,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.w),
              ),
              color: const Color(0xFFD5E1FF),
              margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 0.w),
              child: ListTile(
                leading: SizedBox(
                  height: 5.h,
                  width: 2.w,
                  child: Icon(
                    Icons.mail,
                    size: 17.sp,
                    color: Color(0xFF34539D),
                  ),
                ),
                title: Text('username@gmail.com',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500, //medium
                    )),
              ),
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 188, 188, 188),
            thickness: 0.3.w,
            indent: 6.w,
            endIndent: 5.w,
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 40.w),
            child: Text('Add more information',
                style: GoogleFonts.inter(
                  color: const Color(0xFF989898),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600, //semi-bold
                )),
          ),
          //#########################################
          //card of phone
          // SizedBox(
          //   height: 50, //47
          //   width: 280,
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(80),
          //     ),
          //     color: const Color(0xFFD5E1FF),
          //     // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          //     child: const ListTile(
          //       leading: Padding(
          //         padding: EdgeInsets.only(bottom: 10),
          //         child: Icon(
          //           Icons.phone,
          //           size: 15,
          //           color: Color(0xFF34539D),
          //         ),
          //       ),
          //       title: Padding(
          //         padding: EdgeInsets.only(bottom: 10),
          //         child: Text(
          //           'Phone',
          //           style: TextStyle(fontSize: 10, color: Color(0xFF989898)),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 2.5.h),
        
          const EmailPassWidget(
            mailPassText: 'Phone',
            icon: Icons.phone,
          ),
          SizedBox(height: 2.5.h),
          //##############################################
        
          //card of age & gender
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  width: 30.w,
                  height: 6.8.h,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.w),
                    ),
                    color: const Color.fromARGB(255, 231, 235, 250),
                    child:  ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(bottom: 2.5.w),
                        child: Icon(
                          Icons.boy,
                          size: 18.sp,
                          color: Color(0xFF34539D),
                        ),
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 2.5.w),
                        child: Text(
                          'Age',
                          style:
                              TextStyle(fontSize: 13.sp, color: Color(0xFF989898)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //################################################
              SizedBox(width: 22.w),
              //card of gender
              Flexible(
                child: SizedBox(
                   width: 34.w,
                  height: 6.8.h,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.w),
                    ),
                    color: const Color.fromARGB(255, 231, 235, 250),
                    child:  ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(bottom:2.5.w),
                        child: Icon(
                          Icons.transgender,
                          size: 17.sp,
                          color: Color(0xFF34539D),
                        ),
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 2.5.w),
                        child: Text(
                          'gender',
                          style:
                              TextStyle(fontSize: 14.sp, color: Color(0xFF989898)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //###############################################
          //card of disease
          // const SizedBox(
          //   height: 20,
          // ),
          // SizedBox(
          //   height: 50, //47
          //   width: 280,
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(80),
          //     ),
          //     color: const Color(0xFFD5E1FF),
          //     // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     child: const ListTile(
          //       leading: Padding(
          //         padding: EdgeInsets.only(bottom: 10),
          //         child: Icon(
          //           Icons.health_and_safety,
          //           size: 15,
          //           color: Color(0xFF34539D), // 2B475E
          //         ),
          //       ),
          //       title: Padding(
          //         padding: EdgeInsets.only(bottom: 10),
          //         child: Text(
          //           'Is there Any Disease?',
          //           style: TextStyle(fontSize: 10, color: Color(0xFF989898)),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 2.5.h),
        
          const EmailPassWidget(
            mailPassText: 'Is there Any Disease?',
            icon: Icons.health_and_safety,
          ),
          ////
           SizedBox(height: 10.h),
          Padding(
            padding:  EdgeInsets.all(2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34539D),
                        minimumSize:  Size(50.w, 8.h)),
                    onPressed: () {
                       Navigator.pushNamed(context, '/');
                    },
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600, //semi bold
                      ),
                    )),
                 SizedBox(height: 4.h),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
