import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/utils/constants.dart';
import '../../../../../core/Mapping/Browse_mapping.dart';
import '../../../../../core/helper/token.dart';
import 'widgets/disease_content._widget.dart';

class Browse_Diseases extends StatefulWidget {
  const Browse_Diseases({super.key});

  @override
  State<Browse_Diseases> createState() => _Browse_DiseasesState();
}

class _Browse_DiseasesState extends State<Browse_Diseases> {
  List<Widget> list_disease = [];
  bool isLoading = true;

  // Method to map the disease data to a list of widgets
  List<Widget> _listDisease(responseJson) {
    List<Widget> historyList = [];

    var mapResponse = mapjson(responseJson['data']);
    for (var value in mapResponse) {
      historyList.add(diseases_content_widget(
        Content: value.Name,
        id: value.id,
      ));
     historyList.add(SizedBox(height: 0.8.h));
    }
    return historyList;
  }

  // Method to map JSON data to the BrowseMapping class
  List<BrowseMapping> mapjson(responseJson) {
    List<BrowseMapping> maphistory = [];
    List<dynamic> res = responseJson;
    for (var value in res) {
      maphistory.add(BrowseMapping.Map(value));
    }
    return maphistory;
  }

  void callEndPoint() async {
    final url = Uri.parse("$resourceUrl/api/Disease/get-all");
    String? token = await Tokens.retrieve('access_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authorization token not found."))
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final headers = {
      "Authorization": "Bearer $token",
    };
    try {
      final response = await http.get(url, headers: headers);
      var responseJson = jsonDecode(response.body);

      if (response.statusCode == 200 && responseJson['data'] != null) {
        setState(() {
          list_disease = _listDisease(responseJson);
          isLoading = false;
        });
      } else {
        print("Error: Failed to fetch diseases data.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to fetch diseases data."))
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error occurred while fetching data."))
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    callEndPoint(); // Fetch data when the page is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: LoadingAnimationWidget.inkDrop(
                    color: PrimaryColor,
                    size: 40,
                  )) // Show loader while data is being fetched
          : ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.h),
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
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h),
                          child: Text('Types of Diseases',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 17.5.sp,
                                fontWeight: FontWeight.w600, //semi bold
                              )),
                        ),
                      ],
                    ),
                    //BarPagesWidget(title: 'Types of Diseases',),
                    SizedBox(height: 1.h),
                    ...list_disease,
                  ],
                ),
               // SizedBox(height: 3.h),
              ],
            ),
    );
  }
}
