import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:skin_scan_app/widgets/Login_Register/email&password_widget.dart';
import 'package:skin_scan_app/widgets/Login_Register/loginButton.dart';
import 'package:skin_scan_app/widgets/Login_Register/loginHeader.dart';

import '../Api/doctor_register_api.dart';
import '../widgets/Login_Register/available_dates.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _Register_UserState();
}

class _Register_UserState extends State<DoctorRegister> {
  bool? check1 = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _specialitiesController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _certificationController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _FeesController = TextEditingController();
  final TextEditingController _available_datesController =
      TextEditingController(); // Define the confirm password controller
  final formKey = GlobalKey<FormState>();

  String? _phoneError;
  String? _locationError;
  String? _specialitiesError;
  String? _educationError;
  String? _certificationError;

  String? _experienceError;
  String? _FeesError;
  String? _available_datesError;

  Future<void> validate() async {
    setState(() {
      _phoneError = null;
      _locationError = null;
      _specialitiesError = null;
      _educationError = null;
      _certificationError = null;
      _experienceError = null;
      _FeesError = null;
      _available_datesError = null;
    });

    final phone = _phoneController.text;
    final location = _locationController.text;
    final Specialities = _specialitiesController.text;
    final Education = _educationController.text;
    final Experience = _experienceController.text;
    final Fees = _FeesController.text;

    if (formKey.currentState != null && formKey.currentState!.validate()) {
      if (phone.isEmpty) {
        setState(() {
          _phoneError = 'Phone is required';
          print('Phone: ${_phoneController.text}');
        });
        return;
      }
      if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phone)) {
        setState(() {
          _phoneError = 'Please enter a valid phone number';
        });
        return;
      }
      if (location.isEmpty) {
        setState(() {
          _locationError = 'Please selected a location';
        });
        return;
      }

      // Call the registration API
      bool success = await doctorRegisterApi(phone, location, Education, Fees);

      if (success) {
        // Navigate to login or home page if registration succeeds
        print("=======================sucesss===============================");
        Navigator.pushNamed(context, '/home');
      } else {
        // Show error message if registration fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Registration failed, please try again')),
        );
      }
    } else {
      // Trigger validation to display error messages
      formKey.currentState!.validate();
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

            LoginHeader('More details required'),

            SizedBox(height: 2.7.h),

            //#####################################
            //to create an full name card

            EmailPassWidget(
              mailPassText: 'Phone',
              icon: Icons.call,
              controller: _phoneController,
              errorText: _phoneError,
            ),

            SizedBox(height: 2.5.h),
            //########################################
            //to create an email card
            EmailPassWidget(
              mailPassText: 'location',
              icon: Icons.location_city,
              controller: _locationController,
              errorText: _locationError,
            ),

            SizedBox(height: 2.5.h),

            //#####################################
            //to create a password card

            EmailPassWidget(
              mailPassText: 'Specialities',
              icon: Icons.folder_special,
              controller: _specialitiesController,
              errorText: _specialitiesError,
            ),
            //#####################################
            SizedBox(height: 2.5.h),
            //to create a confirm password card
            EmailPassWidget(
              mailPassText: 'Education ',
              icon: IconData(0xe559, fontFamily: 'MaterialIcons'),
              controller: _educationController,
              errorText: _educationError,
            ),
            //#####################################
            SizedBox(height: 2.5.h),
            EmailPassWidget(
              mailPassText: 'Experience ',
              icon: Icons.stars_rounded,
              controller: _experienceController,
              errorText: _experienceError,
            ),
            //#####################################
            SizedBox(height: 2.5.h),
            AvailableDates(
              mailPassText: 'Your available dates',
              icon: Icons.date_range,
              controller: _available_datesController,
              errorText: _available_datesError,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  setState(() {
                    _available_datesController.text =
                        "${selectedDate.toLocal()}"
                            .split(' ')[0]; 
                  });
                }
              },
            ),

            //#####################################
            SizedBox(height: 2.5.h),
            EmailPassWidget(
              mailPassText: 'Fees ',
              icon: Icons.attach_money,
              controller: _FeesController,
              errorText: _FeesError,
            ),
            //#####################################

            //to create login button
            Loginbutton(
              button: 'Done',
              onPressed: validate,
            ),
            //#####################################
          ]),
        ),
      ),
    );
  }
}
