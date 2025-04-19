import 'package:flutter/material.dart';

import 'config.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,

      
      inputDecorationTheme: const InputDecorationTheme(
        focusColor: Config.primaryColor,
        border: Config.outlinedBorder,
        focusedBorder: Config.focusBorder,
        errorBorder: Config.errorBorder,
        prefixIconColor: Colors.black38,
        enabledBorder: Config.outlinedBorder,
        floatingLabelStyle: TextStyle(color: Config.primaryColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Config.primaryColor,
        unselectedItemColor: Colors.grey.shade700,
      ),
    );
  }
}
