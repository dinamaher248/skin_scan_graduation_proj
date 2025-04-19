import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skin_scan_app/component/button.dart';
import 'appointment3.dart';

class Success extends StatelessWidget {
  Success({required this.doctorId});
  final String doctorId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 3, child: Lottie.asset('assets/success.json')),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 200),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Button(
                  disable: false,
                  width: double.infinity,
                  title: 'Done',
                  onPressed: () => {
                        AppointmentsPage(
                          doctorId: doctorId,
                        ),
                        print("id from success page $doctorId"),
                        Navigator.pushNamed(context, '/home'),
                      }
                      
                      ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
