import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../Api/constants.dart';
import '../Mapping/mapping_upload.dart';
import '../helper/token.dart';
import '../widgets/Rsult/content_result.dart';
import '../widgets/Rsult/doctor_ask_widget.dart';

class Result extends StatefulWidget {
  final String imagePath;

  const Result({super.key, required this.imagePath});

  @override
  State<Result> createState() => _ResultState();
}

String? uploadURL;

class _ResultState extends State<Result> {
  bool _isLoading = false;
  MappingUpload? upload;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // _processImage();
  }

  Future<void> _processImage() async {
    //new
    if (selectedValue == null) {
      print('Please selected a model before analyzing image');
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      MappingUpload result = await ProcessImage(widget.imagePath);
      setState(() {
        upload = result;
      });
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showResultBasedOnSelection() {
    switch (selectedValue) {
      case 'Type':
        uploadURL = "/api/Wound/upload-type";
        break;
      case 'Burn':
        uploadURL = "/api/Wound/upload-burn";
        break;
      case 'Skin disease':
        uploadURL = "/api/Wound/upload-skin";
        break;
      default:
        upload = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 7.h),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedValue = null;
                        upload = null;
                      });
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    icon: Icon(
                      Icons.close,
                      size: 6.w,
                      color: const Color(0xFF34539D),
                    ),
                  ),
                ),
                SizedBox(width: 25.w),
                Padding(
                  padding: EdgeInsets.only(top: 7.h),
                  child: Text('Result',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600, // semi bold
                      )),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF34539D),
                    width: 2.w,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.file(
                    File(widget.imagePath),
                    width: 60.w,
                    height: 35.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            if (upload == null || true)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.5.h, vertical: 0),
                child: DropdownButtonFormField<String>(
                  value: selectedValue,
                  decoration: InputDecoration(
                    labelText: 'Select a model',
                    labelStyle: TextStyle(
                      // fontSize: 15.sp,
                      fontWeight: FontWeight.w700, // semi bold
                      color: PrimaryColor,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: PrimaryColor, // لون الإطار
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: PrimaryColor,
                      ),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  iconEnabledColor: PrimaryColor, // لون السهم
                  iconSize: 30,
                  elevation: 16,
                  style: TextStyle(color: PrimaryColor),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      upload = null;
                      showResultBasedOnSelection();
                      Future.delayed(Duration(milliseconds: 300), () {
                        _processImage();
                      });
                    });
                  },
                  items: <String>['Type', 'Burn', 'Skin disease']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onTap: () {},
                ),
              ),
            SizedBox(height: 2.h),
            if (_isLoading)
              Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: PrimaryColor,
                    size: 40,
                  ))
            else if (upload != null &&
                upload!.name == null &&
                upload!.Risk == null)
              Container(
                padding: EdgeInsets.all(3.w),
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFD5E1FF),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Center(
                  child: Text(
                    'There is no wound or infect',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            else if (upload != null)
              Container(
                padding: EdgeInsets.all(3.w), // Responsive padding
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFD5E1FF),
                  borderRadius:
                      BorderRadius.circular(3.w), // Responsive border radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Section
                    ContentResult(
                        label: 'Name:',
                        value: upload!.name ?? 'There is no wound or infect'),
                    SizedBox(height: 2.h),
                    Divider(color: Colors.black, thickness: 0.2.w),
                    SizedBox(height: 1.h),

                    // Risk Section
                    ContentResult(
                        label: 'Risk:',
                        value: upload!.Risk ?? 'There is no wound or infect'),
                    SizedBox(height: 2.h),
                    Divider(color: Colors.black, thickness: 0.2.w),
                    SizedBox(height: 1.h),

                    // Details Section
                    ContentResult(
                        label: 'Details:',
                        value: upload!.Description ??
                            'please try to take a new photo for your wound'),
                    //  SizedBox(height: 2.h),
                    //more info
                    //SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/BrowseDisease_page',
                              arguments: {'disease': upload},
                            );
                          },
                          child: Text(
                            'Describe more..',
                            style: TextStyle(
                              fontSize: 15.sp, // Responsive text size
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF34539D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 2.h),
            if (upload != null && upload!.name != null && upload!.Risk != null)
              DoctorAskWidget(),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

Future<MappingUpload> ProcessImage(String imagePath) async {
  File image = File(imagePath);
  String url = resourceUrl + "$uploadURL";

  // Prepare the request
  var request = http.MultipartRequest('POST', Uri.parse(url));

  var token = await Tokens.retrieve('access_token');

  // Add headers
  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'multipart/form-data';

  // Attach the file
  request.files.add(
    await http.MultipartFile.fromPath(
      'file', // Key for the file parameter in your API
      image.path,
      filename: basename(image.path), // Get the file name
    ),
  );

  // Send the request
  http.StreamedResponse response = await request.send();

  // Convert the StreamedResponse to a Response
  String responseBody = await response.stream.bytesToString();

  // Parse the JSON response
  Map<String, dynamic> responseJson;
  MappingUpload upload = MappingUpload.Default();
  try {
    responseJson = jsonDecode(responseBody);
    upload = MappingUpload(responseJson: responseJson);
    print('Response Json : $responseJson');
    print('Response Body: $responseBody');
    print('Name: ${upload.name}');
    print('Risk: ${upload.Risk}');
  } catch (e) {
    print('Failed to decode JSON response: $e');
    responseJson = {};
  }

  // Handle the response
  if (response.statusCode == 200) {
    return upload;
  } else {
    throw Exception(
        'Failed to upload photo. Status code: ${response.statusCode}');
  }
}
