import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Api/constants.dart';

class AvailableDates extends StatefulWidget {
  final String mailPassText;
  final IconData icon;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType; //  for custom keyboard type
  final bool readOnly;
  final VoidCallback? onTap;

  const AvailableDates({
    Key? key,
    required this.mailPassText,
    required this.icon,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<AvailableDates> createState() => _AvailableDatesWidgetState();
}

class _AvailableDatesWidgetState extends State<AvailableDates> {
  Map<DateTime, List<TimeOfDay>> availableDatesAndTimes = {};

  // Add selected day

  final List<String> daysOfWeek = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  Future<void> _selectDay() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      if (!availableDatesAndTimes.containsKey(selectedDate)) {
        availableDatesAndTimes[selectedDate] = [];
        _selectTime(selectedDate); // to add time
      }
    }
  }

  // Add time for a specific day
  Future<void> _selectTime(DateTime date) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        availableDatesAndTimes[date]?.add(selectedTime);
      });
    }
  }

  // Remove a specific time from a selected date
  void _removeTime(DateTime date, TimeOfDay time) {
    setState(() {
      availableDatesAndTimes[date]?.remove(time);
      if (availableDatesAndTimes[date]?.isEmpty ?? false) {
        availableDatesAndTimes.remove(date); // Remove date if no times left
      }
    });
  }

  // Format the selected dates and times as a string
  String _formatAvailableDatesAndTimes() {
    return availableDatesAndTimes.entries.map((entry) {
      String date = "${entry.key.toLocal()}".split(' ')[0];
      String times = entry.value.map((time) => time.format(context)).join(", ");
      return "$date: $times";
    }).join("\n");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 86.5.w,
          height: 6.6.h,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.h),
            ),
            color: const Color.fromARGB(255, 231, 235, 250),
            child: TextFormField(
              controller: widget.controller,
              readOnly: true,
              onTap: () async {
                await _selectDay();
                setState(() {
                  widget.controller?.text = _formatAvailableDatesAndTimes();
                });
              },
              cursorColor: const Color(0xFF34539D),
              decoration: InputDecoration(
                labelText: widget.mailPassText,
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF989898),
                ),
                prefixIcon: Icon(
                  widget.icon,
                  size: 4.3.w,
                  color: const Color(0xFF34539D),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                errorText: widget.errorText,
              ),
            ),
          ),
        ),
        if (availableDatesAndTimes.isNotEmpty)
          SizedBox(
            width: 87.5.w,
            child: Wrap(
              spacing: 4.w,
              runSpacing: 1.h,
              children: availableDatesAndTimes.entries.map((entry) {
                String date = "${entry.key.toLocal()}".split(' ')[0];
                List<TimeOfDay> times = entry.value;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: SizedBox(
                      width: 66.w,
                      //height: 5.h,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 186, 202, 245),
                          borderRadius: BorderRadius.circular(80.h),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: SizedBox(
                                width: 30.w,
                                child: Text(
                                  "$date: ${times.map((time) => time.format(context)).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            //Spacer(),
                            SizedBox(
                              width: 5.w,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: PrimaryColor,
                                size: 5.w,
                              ),
                              onPressed: () => _selectTime(entry.key),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                                size: 5.w,
                              ),
                              onPressed: () =>
                                  _removeTime(entry.key, times.first),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
