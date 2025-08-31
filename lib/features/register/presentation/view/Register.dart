import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../data/repo/register_repository.dart';
import '../view_models/register_cubit.dart';
import '../view_models/register_state.dart';
import '../../../login/presentation/view/widgets/loginButton.dart';
import '../../../login/presentation/view/widgets/loginHeader.dart';
import 'widgets/email&password_widget.dart';
import 'widgets/SignUp.dart';
import 'widgets/Social_login.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(RegisterRepository()),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            customSnackBar(
              context,
              state.message ?? "Registration successful",
              Colors.green,
            );

            Navigator.pushNamed(context, '/home');
          }
          if (state is RegisterError) {
            customSnackBar(
              context,
              state.message,
              Colors.red,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();
          String? fullNameError;
          String? emailError;
          String? passwordError;
          String? confirmPasswordError;

          if (state is RegisterValidationError) {
            fullNameError = state.fullNameError;
            emailError = state.emailError;
            passwordError = state.passwordError;
            confirmPasswordError = state.confirmPasswordError;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 9.h),
                    Text('Skin Scan',
                        style: GoogleFonts.kavoon(
                          color:  PrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(height: 6.h),
                    LoginHeader('Create your new account'),
                    SizedBox(height: 2.7.h),
                    EmailPassWidget(
                      mailPassText: 'Full Name',
                      icon: Icons.verified_user,
                      controller: _fullNameController,
                      errorText: fullNameError,
                    ),
                    SizedBox(height: 2.5.h),
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
                    SizedBox(height: 2.5.h),
                    EmailPassWidget(
                      mailPassText: 'Confirm Password',
                      icon: Icons.password,
                      controller: _confirmPasswordController,
                      errorText: confirmPasswordError,
                    ),
                    Loginbutton(
                      isloading: state is RegisterLoading,
                      button: 'Register',
                      onPressed: () {
                        cubit.register(
                          _fullNameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                        );
                      },
                    ),
                    SocialLoginButtons(),
                    const buildSignUp(
                      text: 'Already have an account? ',
                      underlineText: 'Sign in',
                      push: 'login',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
