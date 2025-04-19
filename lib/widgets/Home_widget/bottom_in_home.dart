import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Buttom_home extends StatelessWidget {
  const Buttom_home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/camera');
        },
        backgroundColor: const Color(0xFF34539D),
        child: const Icon(Icons.crop_free, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 6.w), // Reduced padding

        child: Padding(
          padding: EdgeInsets.all(1.0.h), // Reduced padding
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80.w),
            child: SizedBox(
              height: 7.8.h,
              child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 5.w,
                color: const Color(0xFF34539D),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Color(0xFF3FFF49)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/setting');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
