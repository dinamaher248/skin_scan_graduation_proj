import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../register/presentation/view/widgets/Social_login.dart';
import '../../data/repo/login_repository.dart';
import '../../../register/presentation/view/widgets/SignUp.dart';
import '../../../register/presentation/view/widgets/email&password_widget.dart';
import '../view_models/login_cubit.dart';
import '../view_models/login_state.dart';
import 'widgets/loginButton.dart';
import 'widgets/loginHeader.dart';
import 'widgets/remember.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(LoginRepository()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamed(context, '/home');
          }
          if (state is LoginError) {
            customSnackBar(
            context,
            state.message,
            Colors.red,
          );
           
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          String? emailError;
          String? passwordError;

          if (state is LoginValidationError) {
            emailError = state.emailError;
            passwordError = state.passwordError;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 9.h),
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
                        errorText: emailError,
                      ),
                      SizedBox(height: 2.5.h),
                      EmailPassWidget(
                        mailPassText: 'Password',
                        icon: Icons.password,
                        controller: _passwordController,
                        errorText: passwordError,
                      ),
                      const buildRememberMeRow(),
                      Loginbutton(
                        isloading: state is LoginLoading,
                        button: 'Log In',
                        onPressed: () {
                          cubit.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                      ),
                      SocialLoginButtons(),
                      const buildSignUp(
                        text: 'Don’t have account? ',
                        underlineText: 'Sign UP',
                        push: 'Register',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
