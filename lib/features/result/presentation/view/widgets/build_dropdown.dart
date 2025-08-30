
  import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/constants.dart';
import '../../view_models/result_cubit.dart';

Widget buildDropdown(BuildContext context, ResultCubit cubit, final String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.5.h),
      child: DropdownButtonFormField<String>(
        value: cubit.selectedValue,
        decoration: InputDecoration(
          labelText: 'Select a model',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: PrimaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onChanged: (value) {
          if (value != null) {
            cubit.selectModel(value);
            Future.delayed(const Duration(milliseconds: 300), () {
              cubit.processImage(imagePath);
            });
          }
        },
        items: const ['Type', 'Burn', 'Skin disease']
            .map((value) => DropdownMenuItem(value: value, child: Text(value)))
            .toList(),
      ),
    );
  }
