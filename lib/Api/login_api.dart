import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:signalr_core/signalr_core.dart';

import '../helper/Chat.dart';
import '../helper/token.dart';
import 'constants.dart';

Future<bool> login(String? email, String? password) async {
  final url = Uri.parse("$apiUrl/api/Auth/auth/login");
  Chat chat = Chat();

  // Set up the headers
  final headers = {
    "Content-Type": "application/json",
  };

  // Set up the body
  final body = jsonEncode({
    "email": email,
    "password": password,
  });

  try {
    // Send the POST request
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Extract tokens from the response
      final accessToken = data['data']['access'];
      final refreshToken = data['data']['refresh'];

      // Save tokens using SharedPreferences
      await Tokens.set('access_token', accessToken);
      await Tokens.set('refresh_token', refreshToken);
      print("Login successful: ${data['message'] ?? 'Welcome!'}");

      
      return true;
    } else {
      // Handle failure response
      final errorData = jsonDecode(response.body);
      print("Failed to login: ${errorData['message'] ?? 'Unknown error'}");
      return false;
    }
  } catch (e) {
    print("Error occurred: $e");
    return false;
  }
}

