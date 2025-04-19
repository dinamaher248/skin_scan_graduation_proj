import 'dart:convert';
//import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../Api/constants.dart';
import '../Mapping/mapping_upload.dart';
import '../helper/token.dart';
import '../widgets/Rsult/doctor_ask_widget.dart';
import '../widgets/bar_pages_widget.dart';
import '../widgets/Rsult/content_result.dart';

class InfectionPage extends StatefulWidget {
  final int id;

  InfectionPage({super.key, required this.id});

  @override
  State<InfectionPage> createState() => _InfectionPageState();
}

class _InfectionPageState extends State<InfectionPage> {
  MappingUpload? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    GetDetails();
  }

  Future<void> GetDetails() async {
    final url = Uri.parse("$resourceUrl/api/Wound/get-id?id=${widget.id}");
    String? token = await Tokens.retrieve('access_token');

    final headers = {"Authorization": "Bearer $token"};
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          data = MappingUpload(responseJson: jsonResponse);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load data: ${response.statusCode}'),
        ));
      }
    } catch (error) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error occurred: $error'),
      ));
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child:
                  LoadingAnimationWidget.inkDrop(
                    color: PrimaryColor,
                    size: 40,
                  )) // Display loading indicator while data is being fetched
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5.h),

                  BarPagesWidget(title: 'Result'),
                  SizedBox(height: 3.h),

                  // Image Section
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
                        child: data?.image != null
                            ? Image.memory(
                                base64Decode(data!.image as String),
                                width: 60.w,
                                height: 35.h,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                // Fallback in case the image is null or unavailable
                                width: 70.w,
                                height: 30.h,
                                color: Colors.grey, // Placeholder color
                                child: Icon(Icons.image,
                                    size: 10.w, color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Information Container
                  Container(
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E1FF),
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Section
                        ContentResult(label: 'Name:',value:  data?.Name ?? 'Unknown'),
                        SizedBox(height: 2.h),
                        Divider(color: Colors.black, thickness: 0.2.w),
                        SizedBox(height: 1.h),

                        // Risk Section
                        ContentResult(label: 'Risk:',value:  data?.risk ?? 'N/A'),
                        SizedBox(height: 2.h),
                        Divider(color: Colors.black, thickness: 0.2.w),
                        SizedBox(height: 1.h),

                        // Details Section
                        ContentResult(label: 'Details:',value: 
                            data?.description ?? 'No details available'),
                        SizedBox(height: 2.h),

                        // More Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/BrowseDisease_page',
                                  arguments: {'disease': data},
                                );
                              },
                              child: Text(
                                'Describe more..',
                                style: TextStyle(
                                  fontSize: 15.sp, // Responsive text size
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF34539D),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),

                  // Ask Doctor Button
                  SizedBox(height: 2.h),
                  DoctorAskWidget(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
    );
  }
}
