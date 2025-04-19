import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../Api/constants.dart';
import '../helper/token.dart';

class diseases_content_widget extends StatefulWidget {
  diseases_content_widget({
    super.key,
    this.Content,
    this.id,
  });
  String? Content;
  int? id;

  @override
  State<diseases_content_widget> createState() =>
      _diseases_content_widgetState();
}

class _diseases_content_widgetState extends State<diseases_content_widget> {
  bool isLoading = true;

  @override
  Future<Map<String, dynamic>> callEndPoint() async {
    final url = Uri.parse("$resourceUrl/api/Disease/get-id?id=${widget.id}");
    String? token = await Tokens.retrieve('access_token');

    final headers = {
      "Authorization": "Bearer $token",
    };
    try {
      final response = await http.get(url, headers: headers);
      var responseJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseJson as Map<String, dynamic>;
      } else {
        print("Error: Stupid");
        setState(() {
          isLoading = false;
        });
      }
      return new Map<String, dynamic>();
    } catch (error) {
      return new Map<String, dynamic>();
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.7.h),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
          color: const Color.fromARGB(255, 231, 235, 250),
          child: Row(
            children: [
              Flexible(
                child: ListTile(
                  title: Text(
                    '${widget.Content}',
                    style: GoogleFonts.inter(
                      fontSize: 15.5.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600, //semi bold
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/details_disease', arguments: await callEndPoint());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.all(1.5.w),
                    backgroundColor: const Color(0xFF4A6CBF),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
