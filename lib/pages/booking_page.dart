import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../component/booking_datetime_convert.dart';
import '../component/button.dart';
import '../component/custom_appbar.dart';
import '../utils/config.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Api/constants.dart';
import '../helper/token.dart';
import 'success.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key, required this.doctorId});
  String doctorId;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? token;
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;

  Future<void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  // void fetchUserId() async {
  //   try {
  //     final fetchedUserId =
  //         await Tokens.getId(await Tokens.retrieve('access_token'));
  //     setState(() {
  //       widget.doctorId =
  //           fetchedUserId; // Store the fetched userId in the state
  //     });
  //     print("UserId: ");
  //   } catch (e) {
  //     print("Error fetching userId: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await getToken();
    //fetchUserId();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      appBar: const CustomAppBar(
          appTitle: 'Appointment', icon: FaIcon(Icons.arrow_back_ios)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    alignment: Alignment.center,
                    child: const Text(
                      'Weekend is not available, please select another date',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex == index
                                ? const Color(0xFF3959A8)
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _currentIndex == index ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.5),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: Button(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: () async {
                  final getDate = DateConverted.getDate(_currentDay);
                  final getDay = DateConverted.getDay(_currentDay.weekday);
                  final getTime = DateConverted.getTime(_currentIndex!);
                  final patientId =
                      await Tokens.getId(await Tokens.retrieve('access_token'));
                  final url = Uri.parse("$resourceUrl/api/Appointment");
                  var headers = {
                    'Content-Type': 'application/json',
                  };
                  final body = jsonEncode({
                    "DoctorId":
                        int.tryParse(widget.doctorId) ?? widget.doctorId,
                    "PatientId": patientId,
                    "AppointmentDate": _currentDay.toString()
                  });

                  final response =
                      await http.post(url, headers: headers, body: body);
                  print("Response Body: ${response.body}");
                  final responseData = jsonDecode(response.body);
                  // final booking = await DioProvider().bookAppointment(
                  //     getDate, getDay, getTime, doctor?['doctor_id'], token!);
                 // print("Response id: ${responseData['data']['doctorId']}");

                  if (response.statusCode == 200) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                //  Success(doctorId: responseData['data']['doctorId'])),
                              Success(doctorId: widget.doctorId)),
                    );
                    print("id doctor from appointment page${widget.doctorId}");
                  }
                },
                // onPressed: () async {
                //   try {
                //     final patientId = await Tokens.getId(
                //         await Tokens.retrieve('access_token'));
                //     final url = Uri.parse("$resourceUrl/api/Appointment");
                //     final headers = {'Content-Type': 'application/json'};
                //     final body = jsonEncode({
                //       "DoctorId": widget.doctorId,
                //       "PatientId": patientId,
                //       "AppointmentDate": _currentDay.toString()
                //     });

                //     final response =
                //         await http.post(url, headers: headers, body: body);

                //     if (response.statusCode == 200) {
                //       final responseData = jsonDecode(response.body);
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => AppointmentBooked(
                //             doctorId: responseData['data']['doctorId'],
                //           ),
                //         ),
                //       );
                //     } else {
                //       print("Error: ${response.statusCode}");
                //       // Show error dialog or message to the user
                //     }
                //   } catch (e) {
                //     print("Error making appointment: $e");
                //     // Show error dialog or message to the user
                //   }
                // },

                disable: !(_timeSelected && _dateSelected),
                //disable: _timeSelected && !_dateSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
        rowHeight: 48,
        focusedDay: _focusDay,
        calendarFormat: _format,
        currentDay: _currentDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(DateTime.now().year + 1, 12, 31),
        calendarStyle: const CalendarStyle(
          todayDecoration:
              BoxDecoration(color: Color(0xFF3959A8), shape: BoxShape.circle),
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        onFormatChanged: (format) => setState(() => _format = format),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _currentDay = selectedDay;

            if (focusedDay.isAfter(DateTime(DateTime.now().year + 1, 12, 31))) {
              _focusDay = DateTime(DateTime.now().year + 1, 12, 31);
            } else if (focusedDay.isBefore(DateTime.now())) {
              _focusDay = DateTime.now();
            } else {
              _focusDay = focusedDay;
            }

            _dateSelected = true;

            if (selectedDay.weekday == DateTime.saturday ||
                selectedDay.weekday == DateTime.sunday) {
              _isWeekend = true;
              _timeSelected = false;
              _currentIndex = null;
            } else {
              _isWeekend = false;
            }
          });
        });
  }
}
