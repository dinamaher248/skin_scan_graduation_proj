import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';

import '../Api/constants.dart' show PrimaryColor;
import '../widgets/Login_Register/SignUp.dart';
import '../widgets/Login_Register/cart_choice.dart';
import '../widgets/Login_Register/email&password_widget.dart';
import '../widgets/Login_Register/loginButton.dart';
import '../widgets/Login_Register/loginHeader.dart';
import '../widgets/Login_Register/social_login.dart';
import '../Api/register_api.dart';

class Register_User extends StatefulWidget {
  const Register_User({super.key});

  @override
  State<Register_User> createState() => _Register_UserState();
}

class _Register_UserState extends State<Register_User> {
  bool? check1 = false;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // Define the confirm password controller
  final formKey = GlobalKey<FormState>();

  String? _fullNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _isLoading = false;
  Future<void> validateAndRegister() async {
    setState(() {
      _fullNameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _isLoading = true;
    });

    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      // Check for field validity
      if (fullName.isEmpty) {
        setState(() {
          _fullNameError = 'Full Name is required';
          _isLoading = false;
          print('Full Name: ${_fullNameController.text}');
        });
        return;
      }
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        setState(() {
          _emailError = 'Please enter a valid email';
          _isLoading = false;
        });
        return;
      }
      if (password.length < 6) {
        setState(() {
          _passwordError = 'Password must be at least 6 characters long';
          _isLoading = false;
        });
        return;
      }
      if (password != confirmPassword) {
        setState(() {
          _confirmPasswordError = 'Passwords do not match';
          _isLoading = false;
        });
        return;
      }

      bool success = await register(fullName, email, password, confirmPassword);
      setState(() {
        _isLoading = false;
      });
      if (success) {
        print("=======================sucesss===============================");
        //showCart(context);
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Registration failed, please try again')),
        );
      }
    } else {
      formKey.currentState!.validate();
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 5.h),

            //to create a first text 'address of page'
            Text('Skin Scan ',
                style: GoogleFonts.kavoon(
                  color: const Color(0xFF34539D),
                  fontSize: 25,
                  fontWeight: FontWeight.w400, //Regular
                )),

            SizedBox(height: 6.h),

            LoginHeader('create your new account'),

            SizedBox(height: 2.7.h),

            //#####################################
            //to create an full name card

            EmailPassWidget(
              mailPassText: 'Full Name',
              icon: Icons.verified_user,
              controller: _fullNameController,
              errorText: _fullNameError,
            ),

            SizedBox(height: 2.5.h),
            //########################################
            //to create an email card
            EmailPassWidget(
              mailPassText: 'Email',
              icon: Icons.mail,
              controller: _emailController,
              errorText: _emailError,
            ),

            SizedBox(height: 2.5.h),

            //#####################################
            //to create a password card

            EmailPassWidget(
              mailPassText: 'Password',
              icon: Icons.password,
              controller: _passwordController,
              errorText: _passwordError,
            ),
            //#####################################
            SizedBox(height: 2.5.h),
            //to create a confirm password card
            EmailPassWidget(
              mailPassText: 'Confirm Password',
              icon: Icons.password,
              controller: _confirmPasswordController,
              errorText: _confirmPasswordError,
            ),

            //#####################################

            //to create login button
            // _isLoading
            //     ? Column(
            //         children: [
            //           SizedBox(height: 2.5.h),
            //           LoadingAnimationWidget.inkDrop(
            //         color: PrimaryColor,
            //         size: 40,
            //       )
            //         ],
            //       )
            //     :
            Loginbutton(
              isloading: _isLoading,
              button: 'Register',
              onPressed: validateAndRegister,
            ),
            //#####################################

            // SocialLoginButtons(),
            const buildSignUp(
              text: 'Already have an account? Sign in?',
              push: 'login',
            ),
            //#####################################
          ]),
        ),
      ),
    );
  }
}
