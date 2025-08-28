import 'package:flutter/material.dart';

Widget buid_icon(String? Name) {
  if (Name == 'Password') {
    return const Icon(
      Icons.password,
      size: 15,
      color: Color(0xFF34539D),
    );
  } else if (Name == 'Email') {
    return const Icon(
      Icons.mail,
      size: 15,
      color: Color(0xFF34539D),
    );
  } else if (Name == 'Full Name') {
    return const Icon(
      Icons.verified_user,
      size: 15,
      color: Color(0xFF34539D),
    );
  } else if (Name == 'search') {
    return const Icon(
      Icons.search,
      size: 15,
      color: Color(0xFF34539D),
    );
  } else {
    return const Icon(
      Icons.error,
      size: 15,
      color: Colors.red,
    );
  }
}
