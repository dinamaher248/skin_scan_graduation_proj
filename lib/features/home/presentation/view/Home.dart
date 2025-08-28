import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/Mapping/map_history.dart';
import '../../../../core/helper/token.dart';
import 'widgets/wounds_home_card.dart';
import '../../../setting/Setting_widget/barOfHome&setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> history = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    callEndPoint();
  }

  List<Widget> _listHistory(responseJson) {
    List<Widget> historyList = [];

    var mapResponse = mapjson(responseJson);
    for (var value in mapResponse) {
      historyList.add(Wounds_card(data: value));
      historyList.add(
        SizedBox(height: 2.h),
      );
    }
    if (historyList.isEmpty) {
      historyList.add(Image(
        image: const AssetImage('Images/photo_HOME.jpg'),
        width: 33.w,
        height: 40.h,
      ));
    }
    return historyList;
  }

  List<MapHistory> mapjson(responseJson) {
    List<MapHistory> maphistory = [];
    List<dynamic> res = responseJson['data'];
    for (var value in res) {
      maphistory.add(MapHistory.Map(value));
    }
    return maphistory;
  }


 
Future<void> callEndPoint() async {
  final url = Uri.parse("$resourceUrl/api/Wound/get-all");
  String? token = await Tokens.retrieve('access_token');
  final headers = {
    "Authorization": "Bearer $token",
  };
  try {
    final response = await http.get(url, headers: headers);
    var responseJson = jsonDecode(response.body);
    print('API Response Data: $responseJson');
    if (response.statusCode == 200) {
      setState(() {
        history = _listHistory(responseJson);
        isLoading = false;
      });
    } else {
      print("Error: ${response.body}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (error) {
    print('Error : $error');
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const  BarHomeSetting(),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Recent Analyses',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6D7A98),
                      fontSize: 16.8.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            isLoading
                ? LoadingAnimationWidget.inkDrop(
                    color: PrimaryColor,
                    size: 40,
                  )
                : Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            return history[index];
                          },
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/camera');
        },
        backgroundColor: const Color(0xFF34539D),
        child: const Icon(Icons.crop_free, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 6.w),
        child: Padding(
          padding: EdgeInsets.all(1.0.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80.w),
            child: SizedBox(
              height: 7.8.h,
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 5.w,
                color: const Color(0xFF34539D),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Color(0xFF3FFF49)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                       Navigator.pushNamed(context, '/setting');
                    
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
