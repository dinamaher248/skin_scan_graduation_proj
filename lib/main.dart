import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'features/clincs/presentation/view/clincs.dart';
import 'features/chat/presentation/view/chat.dart';
import 'features/doctors/presentation/view/doctors.dart';
import 'features/setting/diseases/presentation/view/Browse_disease.dart';
import 'core/helper/token.dart';
import 'features/setting/about_us/presentation/view/about_us.dart';
import 'features/appointment/presentation/view/appointment3.dart';
import 'features/setting/diseases/presentation/view/browes diseases1.dart';
import 'features/doctors/presentation/view/call.dart';
import 'features/setting/cart.dart';
import 'features/doctors/presentation/view/doctor_info.dart';
import 'features/doctors/presentation/view/doctor_register.dart';
import 'features/setting/feedback/presentation/view/feedback.dart';
import 'features/home/presentation/view/Home.dart';
import 'features/setting/Setting.dart';
import 'features/camera/presentation/view/camera.dart';
import 'features/setting/diseases/presentation/view/details_diseases.dart';
import 'features/register/presentation/view/Register.dart';
import 'features/splash/presentation/view/splash_view.dart';
import 'features/login/presentation/view/login.dart';
import 'features/setting/invite/presentation/view/invite.dart';
import 'features/splash/presentation/view/onboarding1.dart';
import 'features/splash/presentation/view/onboarding2.dart';
import 'features/profile/presentation/view/user_info.dart';
import 'features/profile/presentation/view/users_page.dart';

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

  const MyApp({super.key, required this.initialRoute});

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
        '/call': (context) => const CallingPage(),
        '/users': (context) => const Users(),
        '/doctor_info': (context) => const DoctorInfo(id: '',),
        '/doctorDetails': (context) => const DoctorRegister(),
        '/appointmentAll': (context) => AppointmentsPage(doctorId: '',),
        '/clincs': (context) => const Clincs(),
   
      },
    );
  }
}
