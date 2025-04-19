import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Api/constants.dart';
import '../../Mapping/map_history.dart';
import '../../Mapping/mapping_upload.dart';
import 'package:http/http.dart' as http;

import '../../helper/token.dart';
import '../../pages/infections.dart';

class Wounds_card extends StatelessWidget {
  Wounds_card({super.key, this.data});
  MapHistory? data;
  MappingUpload? upload;

  @override
  Widget build(BuildContext context) {
    final String base64String =
        data?.image as String; // This should be your full base64 string.
    Uint8List imageBytes = base64Decode(base64String);
    String extractedName =
        (data?.Name ?? 'Unknown').trim().replaceAll(RegExp(r'\s*/\s*$'), '');

    String ExtractedName =
        (data?.name ?? 'Unknown').trim().replaceAll(RegExp(r'\s*/\s*$'), '');

    print("Extracted Name (Cleaned): $extractedName");

    return Padding(
      padding: EdgeInsets.only(right: 7.w),
      child: Padding(
          padding: EdgeInsets.only(left: 7.w),
          child: Container(
            height: 15.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 235, 250),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.5.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(extractedName,
                             //data?.Name as String,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600, //semi bold

                                )),
                          ],
                        ),
                      ),
                      ////
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name :',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 13.8.sp,
                                      fontWeight: FontWeight.w500, //medium
                                    )),
                                //###
                                SizedBox(height: 1.h),
                                Text('Date : ',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 13.8.sp,
                                      fontWeight: FontWeight.w500, //medium
                                    )),
                              ],
                            ),
                            ///////////////
                            SizedBox(width: 2.w),
                            //data information
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ExtractedName,
                                    // data?.name as String ?? 'No Name Available',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 13.8.sp,
                                      fontWeight: FontWeight.w500, //medium
                                    )),
                                //###
                                SizedBox(height: 1.h),
                                Text(data?.AddedDate as String,
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 13.8.sp,
                                      fontWeight: FontWeight.w500, //medium
                                    )),
                              ],
                            ), //col of info
                          ],
                        ), //row of two col
                      ), //padding of this rwo
                      //add icon
                      SizedBox(height: 1.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.7.h,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.1.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  // call the getbyid end point(data['id'])
                                  if (data?.id != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InfectionPage(id: data!.id!),
                                      ),
                                    );
                                  } else {
                                    print("Error: ID is null");
                                  }

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         InfectionPage(id: data?.id as int),
                                  //   ),
                                  // );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: const Color(0xFF4A6CBF),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 3.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Image.memory(
                            imageBytes,
                            width: 40.w,
                            height: 10.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
