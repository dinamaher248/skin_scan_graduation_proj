import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';

import '../../../../core/utils/constants.dart';
import '../../../chat/presentation/view/chat.dart';
import '../../../appointment/presentation/view/booking_page.dart';


class DoctorInfo extends StatefulWidget {
  final String id;
  const DoctorInfo({super.key, required this.id});
  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  bool isLoading = false;
  Map<String, dynamic>? clinicsDetails;

  Future<void> fetchDoctorInfo(String location) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('$resourceUrl/api/pharmacy/${widget.id}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        print("responseJson of Details Clinic $responseJson");
        setState(() {
          clinicsDetails = responseJson;
          print("clinic details $clinicsDetails");
          isLoading = false;
        });
      } else {
        print("Failed: ${response.body}");
        setState(() {
          isLoading = false;
          clinicsDetails = {};
          print(clinicsDetails);
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
        clinicsDetails = {};
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDoctorInfo("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(top: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 22.3.sp,
                        color: const Color(0xFF34539D),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 65.w),
                  // IconButton(
                  //   icon: Icon(Icons.message_outlined,
                  //       color: const Color(0xFF34539D), size: 3.h),
                  //   onPressed: () {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => MessagePage(
                  //                 idDoctor: clinicsDetails!["doctor"]["id"],
                  //                 userName: clinicsDetails!["doctor"]
                  //                     ["fullName"],
                  //               )),
                  //     ).then((_) {
                  //       setState(() {});
                  //     });
                  //   },
                  // ),
                  IconButton(
                    icon: Icon(Icons.message_outlined,
                        color: const Color(0xFF34539D), size: 3.h),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagePage(
                            idDoctor: clinicsDetails!["doctor"]["id"],
                            userName: clinicsDetails!["doctor"]["fullName"],
                          ),
                        ),
                      ).then((_) {
                        if (mounted) {
                          setState(() {});
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            // Display doctor inf
            clinicsDetails != null
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: PrimaryColor,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                            radius: 20.w,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                const AssetImage('Images/doctor_Photo_b.jpg')),
                      ),
                      Text(
                          clinicsDetails!["doctor"]["fullName"] ??
                              'Unknown Name',
                          style: GoogleFonts.inter(
                              fontSize: 17.5.sp, fontWeight: FontWeight.w600)),
                      Text(
                          clinicsDetails!["doctor"]["email"] ?? 'Unknown Email',
                          style: GoogleFonts.inter(fontSize: 14.sp)),
                      Text(
                          clinicsDetails!["doctor"]["phoneNumber"] ??
                              'Unknown Phone',
                          style: GoogleFonts.inter(fontSize: 14.sp)),
                    ],
                  )
                : isLoading
                    ? LoadingAnimationWidget.inkDrop(
                        color: PrimaryColor,
                        size: 40,
                      )
                    : const Text("No data available"),

            SizedBox(
              height: 5.h,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 5.w),
            //   child: Row(
            //     children: [
            //       Text(
            //         'About',
            //         style: GoogleFonts.inter(
            //           color: Colors.black,
            //           fontSize: 17.5.sp,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 1.h,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 5.w),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 90.w,
            //         child: Text(
            //           'Dr. John Doe specializes in diagnosing and treating skin conditions. He is known for his patient-focused approach and up-to-date knowledge in dermatology.',
            //           style: GoogleFonts.inter(
            //             color: Colors.black,
            //             fontSize: 15.5.sp,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 4.h,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  Text(
                    'Clinic Address',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.location_on_outlined,
                        color: PrimaryColor,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      (clinicsDetails?["location"] as String?)?.isNotEmpty ==
                              true
                          ? clinicsDetails!["location"]
                          : "No Address",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  Text(
                    'Specialization',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      'Dermatologist',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 4.h,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 5.w),
            //   child: Row(
            //     children: [
            //       Text(
            //         'Experience',
            //         style: GoogleFonts.inter(
            //           color: Colors.black,
            //           fontSize: 17.5.sp,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 1.h,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 5.w),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 90.w,
            //         child: Text(
            //           '12 years',
            //           style: GoogleFonts.inter(
            //             color: Colors.black,
            //             fontSize: 15.5.sp,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  Text(
                    'Available',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  SizedBox(
                      width: 90.w,
                      child: Text(
                        ((clinicsDetails?["start"] as String?)?.isNotEmpty ==
                                    true
                                ? clinicsDetails!["start"]
                                : "No available date") +
                            " to " +
                            ((clinicsDetails?["close"] as String?)
                                        ?.isNotEmpty ==
                                    true
                                ? clinicsDetails!["close"]
                                : "No available date"),
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  Text(
                    'Fees',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      clinicsDetails?["fees"] != null
                          ? "${clinicsDetails!["fees"].toString()} EGP"
                          : "No fees info",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.all(2.w),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34539D),
                        minimumSize: Size(50.w, 5.h)),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingPage(
                                doctorId: clinicsDetails!["doctor"]["id"]
                                    .toString())),
                      );
                    },
                    child: Text(
                      'Book Appointment',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600, //semi bold
                      ),
                    )),
              ]),
            )
          ]),
        ));
  }
}

// Widget doctorInfoCard(MapDoctor doctor) {
//   return Column(
//     children: [
//       CircleAvatar(
//           radius: 20.w,
//           backgroundImage: const AssetImage('Images/doctor_Photo_b.jpg')),
//       Text(clinicsDetails!["doctor"]["fullName"] ?? 'Unknown Name',
//           style: GoogleFonts.inter(
//               fontSize: 17.5.sp, fontWeight: FontWeight.w600)),
//       Text(clinicsDetails!["doctor"]["email"] ?? 'Unknown Email',
//           style: GoogleFonts.inter(fontSize: 14.sp)),
//       Text(clinicsDetails!["doctor"]["phoneNumber"] ?? 'Unknown Phone',
//           style: GoogleFonts.inter(fontSize: 14.sp)),
//     ],
//   );
// }
