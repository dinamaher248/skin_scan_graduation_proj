import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../view_models/login_api.dart';
import '../../../../core/helper/token.dart';
import '../../../register/presentation/view/widgets/SignUp.dart';
import '../../../register/presentation/view/widgets/email&password_widget.dart';
import 'widgets/loginButton.dart';
import 'widgets/loginHeader.dart';

List<dynamic> users = [];

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void dispose() {
    // التخلص من Controllers عند إغلاق الصفحة
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _emailError;
  String? _passwordError;

  Future<void> validateAndLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      // Check for email and password validity
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
      // استدعاء دالة تسجيل الدخول
      bool success = await login(email, password);
      setState(() {
        _isLoading = false;
      });
      if (success) {
        String? token = await Tokens.retrieve('access_token');
        print(await Tokens.getName(token));

        // الانتقال إلى الصفحة الرئيسية إذا نجحت عملية تسجيل الدخول
        Navigator.pushNamed(context, '/home');
      } else {
        // عرض رسالة خطأ إذا فشلت عملية تسجيل الدخول
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed, please try again')),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // تفعيل التحقق لإظهار الرسائل
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Text('Skin Scan',
                    style: GoogleFonts.kavoon(
                        color: const Color(0xFF34539D), fontSize: 22.sp)),
                SizedBox(height: 7.h),
                LoginHeader('Login To your Account!'),
                SizedBox(height: 2.7.h),
                EmailPassWidget(
                  mailPassText: 'Email',
                  icon: Icons.mail,
                  controller: _emailController,
                  errorText: _emailError,
                ),
                SizedBox(height: 2.5.h),
                EmailPassWidget(
                  mailPassText: 'Password',
                  icon: Icons.password,
                  controller: _passwordController,
                  errorText: _passwordError,
                  // obscureText: true, // لإخفاء كلمة المرور
                ),
                //const buildRememberMeRow(),
                Loginbutton(
                  isloading: _isLoading,
                  button: 'Log In',
                  onPressed: validateAndLogin,
                ),
                //if (_isLoading)
                  // Container(
                  //     child: Center(
                  //   child: LoadingAnimationWidget.inkDrop(
                  //     color: PrimaryColor,
                  //     size: 40,
                  //   ),
                  // )),
                // SocialLoginButtons(),
                const buildSignUp(
                  text: 'Don’t have account? Sign UP',
                  push: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
