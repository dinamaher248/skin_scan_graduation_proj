import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:skin_scan_app/pages/clincs.dart';
import 'helper/token.dart';
import 'pages/Doctors.dart';
import 'pages/about_us.dart';
import 'pages/appointment3.dart';
import 'pages/booking_page.dart';
import 'pages/browes diseases1.dart';
import 'pages/call.dart';
import 'pages/cart.dart';
import 'pages/chat.dart';
import 'pages/doctor_info.dart';
import 'pages/doctor_register.dart';
import 'pages/feedback.dart';
import 'pages/success.dart';
import 'pages/Home.dart';
import 'pages/Setting.dart';
import 'pages/browse_disease.dart';
import 'pages/camera.dart';
import 'pages/details_diseases.dart';
import 'pages/Register.dart';
import 'pages/first.dart';
import 'pages/login.dart';
import 'pages/invite.dart';
import 'pages/second.dart';
import 'pages/third.dart';
import 'pages/user_info.dart';
import 'pages/users_page.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await _requestCameraPermission();

  bool hasExpired = await Tokens.isExpired(await Tokens.retrieve('access_token'));
  String initialRoute = hasExpired ? '/' : '/login';  
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MyApp(initialRoute: initialRoute);
      },
    ),
  );
}
// DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => ResponsiveSizer(
//       builder: (context, orientation, deviceType) {
//         return MyApp(initialRoute: initialRoute);
//       },
//     ),
//     ),
Future<void> _requestCameraPermission() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}




class MyApp extends StatelessWidget {
final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const Skin_Scan_App(),
        '/second': (context) => const MySecond_intro(),
        '/third': (context) => const MyThird_intro(),
        '/user': (context) => const User_Info(),
        '/login': (context) => const LoginUser(),
        '/Register': (context) => const Register_User(),
        '/home': (context) => const HomePage(), //
        '/setting': (context) => const Setting_page(),
        '/BrowseDisease': (context) => const Browse_Diseases(),
        '/BrowseDisease_page': (context) => const BrowseDiseases1(),
        '/details_disease': (context) => const DetailsDiseases(),
        '/camera': (context) => CameraPage(myCameras: cameras),
        '/invite': (context) => const Invite(),
        '/aboutUs': (context) => const about_us(),
        '/cart': (context) => const cart(),
        '/doctors': (context) => Doctors(),
        '/feedback': (context) => FeedbackPage(),
        '/chat': (context) => MessagePage(idDoctor: '',userName: '',),
        '/call': (context) => CallingPage(),
        '/users': (context) => Users(),
        '/doctor_info': (context) => DoctorInfo(id: '',),
        '/doctorDetails': (context) => DoctorRegister(),
        '/appointmentAll': (context) => AppointmentsPage(doctorId: '',),
        '/clincs': (context) => Clincs(),
   
      },
    );
  }
}
