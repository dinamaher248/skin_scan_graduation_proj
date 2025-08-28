import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/Mapping/map_doctor.dart';
import '../../../chat/presentation/view/chat.dart';
import '../../../home/presentation/view/Home.dart';

class Doctors extends StatefulWidget {
  const Doctors({super.key});
  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  List<Widget> history = [];
  bool isLoading = true;
  List<MapDoctor> docInfo = [];
  double userRating = 0.0;
// email
  @override
  void initState() {
    super.initState();
    callEndPoint(); // Fetch data when the page is loaded
  }

  List<Widget> _listDoctors(responseJson) {
    List<Widget> historyList = [];

    var mapResponse = mapjson(responseJson);
    for (var value in mapResponse) {
      historyList.add(_buildDoctorCard(
        context: context,
        name: 'Dr.${value.Name as String}',
        info: value.Email as String,
        imagePath: 'Images/doctor_Photo_b.jpg',
        ratingSize: 4.h,
        iconSize: 3.5.h,
        id: value.Id!,
      ));
      historyList.add(
        SizedBox(height: 3.h),
      );
    }
    return historyList;
  }

  List<MapDoctor> mapjson(responseJson) {
    List<MapDoctor> maphistory = [];
    List<dynamic> res = responseJson['data'];
    for (var value in res) {
      maphistory.add(MapDoctor.Map(value));
    }
    docInfo = maphistory;
    return maphistory;
  }

  // Future<>
  void callEndPoint() async {
    final url = Uri.parse("$resourceUrl/api/Specialization/get-all-docs");
    //String? token = await Tokens.retrieve('access_token');

    try {
      final response = await http.get(url);
      var responseJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          history = _listDoctors(responseJson);
          isLoading = false;
        });
      } else {
        print("Error: Stupid");
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
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_circle_left_outlined,
                          size: 22.3.sp,
                          color: const Color(0xFF34539D),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text('Doctor List',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 17.5.sp,
                            fontWeight: FontWeight.w600, //semi bold
                          )),
                    ),
                  ],
                ),
                // BarPagesWidget(title: 'Doctor List'),
                SizedBox(
                  height: 3.h,
                ),
                isLoading
                    ? Center(
                        child: LoadingAnimationWidget.inkDrop(
                        color: PrimaryColor,
                        size: 40,
                      ))
                    : Column(
                        children: history,
                      ),
              ],
            ),
          ],
        ));
  }

  Widget _buildDoctorCard({
    required BuildContext context,
    required String name,
    required String info,
    required String imagePath,
    required double ratingSize,
    required double iconSize,
    required String id,
  }) {
    return GestureDetector(
      // onTap: () => DoctorInfo(
      //   doctorId: id,
      // ),
      child: Container(
        height: 25.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: const Color(0xFFB8CDFF),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
          child: Row(
            children: [
              // Text Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Text(
                        name,
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 40, 68, 131),
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Text(
                        info,
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 80, 76, 76),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 3.h),
                          Icon(Icons.star, color: Colors.yellow, size: 3.h),
                          Icon(Icons.star, color: Colors.yellow, size: 3.h),
                          Icon(Icons.star, color: Colors.yellow, size: 3.h),
                          Icon(Icons.star_half,
                              color: Colors.yellow, size: 3.h),
                        ],
                      ),
                    ),
                    //for changing rating
                    // Padding(
                    //   padding: EdgeInsets.only(left: 3.w),
                    //   child: RatingBar.builder(
                    //     initialRating: userRating,
                    //     minRating: 1,
                    //     direction: Axis.horizontal,
                    //     allowHalfRating: true,
                    //     itemCount: 5,
                    //     itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    //     itemBuilder: (context, _) => Icon(
                    //       Icons.star,
                    //       size: 0.h,
                    //       color: Colors.amber,
                    //     ),
                    //     onRatingUpdate: (rating) {
                    //       setState(() {
                    //         userRating =
                    //             rating;
                    //       });
                    //       print("doctor rating $rating stars ");
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        // SizedBox(width: 3.w),
                        // IconButton(
                        //   icon: Icon(Icons.call,
                        //       color: Color(0xFFF70C0C), size: 3.h),
                        //   onPressed: () {
                        //     Navigator.pushNamed(context, '/call');
                        //   },
                        // ),
                        SizedBox(width: 2.w),
                        IconButton(
                          icon: Icon(Icons.message_outlined,
                              color: const Color(0xFF34539D), size: 3.h),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessagePage(
                                        idDoctor: id,
                                        userName: name,
                                      )),
                            ).then((_) {
                              if (mounted) {
                                setState(() {});
                              }
                            });
                          },
                        ),
                        SizedBox(width: 2.w),
                        // IconButton(
                        //   icon: Icon(Icons.calendar_month,
                        //       color: Color.fromRGBO(52, 83, 157, 1), size: 3.h),
                        //   onPressed: () {
                        //     // pass the doctor id as argument
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               BookingPage(doctorId: id)),
                        //     );
                        //     print("id doctor from doctor list$id");
                        //   },
                        // ),
                        // SizedBox(width: 2.w),
                      ],
                    ),
                  ],
                ),
              ),
              // Image with circular shape
              ClipOval(
                child: Image.asset(
                  imagePath,
                  height: 15.h,
                  width: 15.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
