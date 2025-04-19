// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class CallingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 138, 169, 209),
//       body: SafeArea(
//         child: Column(
//           children: [

//             Padding(
//               padding: EdgeInsets.only(top: 5.h, left: 5.w),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 35.sp, // حجم الدائرة
//                     backgroundImage: AssetImage('Images/doctor_Photo.jpg'),
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(
//                     'Dr. Natalie Nash',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 1.h),
//                   Text(
//                     'Calling..',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Padding(
//               padding: EdgeInsets.only(bottom: 5.h),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: CircleAvatar(
//                   radius: 25.sp,
//                   backgroundColor: Colors.red,
//                   child: Icon(
//                     Icons.call_end,
//                     color: Colors.white,
//                     size: 20.sp,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class CallingPage extends StatefulWidget {
  @override
  _CallingPageState createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  late RtcEngine _engine;
  bool _joined = false;
  String appid = 'c966f72bfb96496d9eb23b011baa375a';

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    // إنشاء Agora RtcEngine
    _engine = createAgoraRtcEngine();

    // إعدادات Agora
    await _engine.initialize(RtcEngineContext(
      appId: appid,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    // تمكين الصوت
    await _engine.enableAudio();

    // إعداد event handler
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int uid) {
          // تعديل هنا
          setState(() {
            _joined = true;
          });
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          setState(() {
            _joined = false;
          });
        },
        onError: (ErrorCodeType err, String msg) {
          print('Error: $err, Message: $msg');
        },
      ),
    );

    // الانضمام إلى القناة
    await _engine.joinChannel(
      token: '',
      channelId: 'test_channel',
      uid: 0,
      options: ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    // مغادرة القناة وتدمير Agora engine
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 169, 209),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35.sp, // حجم الدائرة
                    backgroundImage: AssetImage('Images/doctor_Photo.jpg'),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Dr. Natalie Nash',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    _joined ? 'In Call...' : 'Calling...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: GestureDetector(
                onTap: () {
                  _engine
                      .leaveChannel(); // Leave the Agora channel when the user ends the call
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 25.sp,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
