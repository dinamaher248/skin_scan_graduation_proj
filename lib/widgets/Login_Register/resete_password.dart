import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
// import 'package:graduate_proj/widgets/Login_Register/email&password_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle password reset logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Password reset link sent to ${_emailController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 2.w),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 6.w,
                    color: const Color(0xFF34539D),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text('Reset Password',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600, //semi bold
                    )),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your email to reset your password',
                    style:
                        GoogleFonts.inter(fontSize: 15.sp, color: Colors.black),
                  ),
                  SizedBox(height: 3.h),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFF989898),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.w),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 231, 235, 250),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.w),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 231, 235, 250),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80.w),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        size: 4.3.w,
                        color: const Color(0xFF34539D),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  // EmailPassWidget(mailPassText: 'Email',icon: Icons.email,),
                  SizedBox(height: 3.h),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 7.h,
                      child: ElevatedButton(
                        onPressed: resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF34539D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                        child: Text(
                          'Reset Password',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.8.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
