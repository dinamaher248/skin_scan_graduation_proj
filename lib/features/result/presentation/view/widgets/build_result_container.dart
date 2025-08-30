import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/Mapping/mapping_upload.dart';
import 'content_result.dart';

Widget buildResultContainer(MappingUpload upload, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(3.w),
    margin: EdgeInsets.symmetric(horizontal: 8.w),
    decoration: BoxDecoration(
      color: const Color(0xFFD5E1FF),
      borderRadius: BorderRadius.circular(3.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentResult(label: 'Name:', value: upload.name ?? 'N/A'),
        SizedBox(height: 2.h),
        Divider(color: Colors.black, thickness: 0.2.w),
        ContentResult(label: 'Risk:', value: upload.Risk ?? 'N/A'),
        Divider(color: Colors.black, thickness: 0.2.w),
        ContentResult(
            label: 'Details:',
            value: upload.Description ?? 'Try taking a new photo'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/BrowseDisease_page',
                    arguments: {'disease': upload});
              },
              child: Text(
                'Describe more..',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF34539D),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
