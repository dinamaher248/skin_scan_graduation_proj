import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
               SizedBox(height: 10.h), 
              Align(
                alignment: Alignment.topRight, 
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF34539D), 
                      width: 0.w, 
                    ),
                    borderRadius: BorderRadius.circular(0.w), 
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(0.w), 
                    child: Image.asset(
                      'Images/cart.jpg',
                      width: 70.w,
                      height: 45.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 5.h), // المسافة بين الصورة والنص الجديد
              Container(
                padding:  EdgeInsets.all(2.h),
                margin:  EdgeInsets.symmetric(horizontal: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white, // لون الخلفية
                  borderRadius: BorderRadius.circular(15.w), // حواف مستديرة
                ),
                child:  Center(
                  child: Text(
                    'Success! ',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF34539D),
                    ),
                  ),
                ),
              ),
               SizedBox(height: 3.h), // المسافة بين الصورة والنص الجديد
              Container(
                padding:  EdgeInsets.all(0.w),
                margin:  EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white, // لون الخلفية
                  borderRadius: BorderRadius.circular(15.w), // حواف مستديرة
                ),
                child:  Center(
                  child: Text(
                    'Your Process has  done successfully  ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFAAA7A7),
                    ),
                  ),
                ),
              ),

               SizedBox(height: 5.h),
              Container(
                padding:  EdgeInsets.all(3.w), // هنا طول المستطيل
                margin:  EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF34539D), // لون الخلفية
                  borderRadius: BorderRadius.circular(30.w), // حواف مستديرة
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // يجعل الأيقونة والنص في المنتصف
                  children:  [
                    Text(
                      'continue',
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
