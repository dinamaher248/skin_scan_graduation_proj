import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';
import '../Api/constants.dart';
import '../Mapping/mapping_appointement.dart';
import '../helper/token.dart';
import 'Setting.dart';
import '../widgets/Setting_widget/barOfHome&setting.dart';
import 'package:http/http.dart' as http;

class AppointmentsPage extends StatefulWidget {
  AppointmentsPage({required this.doctorId});
  String? doctorId;

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<MappingAppointement> appointments = [];
  List<Widget> history = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchUserId().then((_) {
      print("Doctor ID after fetching: ${widget.doctorId}");

      if (widget.doctorId != null) {
        callEndPoint();
      }
    });
    if (widget.doctorId == null) {
      print("doctorId = null");
    } else {
      print("doctorId /toooo= ${widget.doctorId}");
    }
  }

  Future<String> _getUserName() async {
    return await Tokens.getName(await Tokens.retrieve('access_token'));
  }

  String? userType;

  Future<void> fetchUserId() async {
    try {
      final fetchedUserId =
          await Tokens.getId(await Tokens.retrieve('access_token'));

      setState(() {
        widget.doctorId = fetchedUserId.toString();
      });
      print("Fetched doctorId: ${widget.doctorId}");
    } catch (e) {
      print("Error fetching userId or userType: $e");
    }
  }

  List<Widget> _listAppoint(responseJson) {
    List<Widget> historyList = [];

    var mapResponse = mapjson(responseJson);
    for (var value in mapResponse) {
      var card = AppointmentCard(
        doctorName: value.doctorName ?? "Unknown",
        specialization: 'Skin diseases',
        time: value.appointmentDate.toString(),
        rating: 4.9,
        imageUrl: 'Images/user.png',
        onDelete: () {
          setState(() {
            appointments.remove(value);
          });
        },
      );

      historyList.add(card);
    }

    return historyList;
  }

  List<MappingAppointement> mapjson(responseJson) {
    List<MappingAppointement> maphistory = [];
    List<dynamic> res = responseJson['data'];
    print("API returned ${res.length} appointments");

    for (var value in res) {
      var appointment = MappingAppointement.fromJson(value);
      print(
          "Mapped appointment: ${appointment.doctorName}, Date: ${appointment.appointmentDate}");

      maphistory.add(appointment);
    }
    return maphistory;
  }

  void callEndPoint() async {
    final url =
        Uri.parse("$resourceUrl/api/Appointment?doctorId=${widget.doctorId}");
    print("Doctor ID from all appoinmets page : ${widget.doctorId}");

    print("Fetching data from: $url");

    try {
      final response = await http.get(url);
      var responseJson = jsonDecode(response.body);
      if (response.body.isEmpty) {
        print("Error: Response body is empty");
        return;
      }

      print("Response JSON: $responseJson");
      if (response.statusCode == 200) {
        setState(() {
          history = _listAppoint(responseJson);
          isLoading = false;
          print("Full API Response: $responseJson");
          print(history);
          print("Number of Appointments: ${history.length}");
        });
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Active Appointments',
            style: TextStyle(fontSize: 6.w, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Search previous appointments',
            //     prefixIcon: Icon(Icons.search, size: 6.w),
            //     filled: true,
            //     fillColor: Colors.grey[200],
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(5.w),
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            // ),

            SizedBox(height: 2.h),
            Expanded(
              child: isLoading
                  ? Center(
                      child: LoadingAnimationWidget.inkDrop(
                    color: PrimaryColor,
                    size: 40,
                  ))
                  : ListView(children: history),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String time;
  final double rating;
  final String imageUrl;
  final VoidCallback onDelete;

  const AppointmentCard({
    required this.doctorName,
    required this.specialization,
    required this.time,
    required this.rating,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: 7.w,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 4.5.w,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    specialization,
                    style: TextStyle(color: Colors.grey[700], fontSize: 3.5.w),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey[600], fontSize: 3.5.w),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    // Icon(Icons.star, color: Colors.amber, size: 4.w),
                    // Text(rating.toString(), style: TextStyle(fontSize: 4.w)),
                  ],
                ),
                // TextButton(
                //   onPressed: onDelete,
                //   child: Text(
                //     'Cancel',
                //     style: TextStyle(color: Colors.red, fontSize: 4.w),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
