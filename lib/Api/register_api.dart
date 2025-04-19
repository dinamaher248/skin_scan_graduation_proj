import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;
import '../helper/token.dart';
import 'constants.dart';

Future<bool> register(String? fullName, String? email, String? password,
    String? confirmPassword) async {
  final url = Uri.parse(apiUrl + "/api/Auth/auth/register");

  // Set up the headers
  final headers = {
    "Content-Type": "application/json",
  };

  // Set up the body for registration
  final body = jsonEncode({
    "fullName": fullName,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
  });

  try {
    // Send the POST request
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    /*
    [password structure]
    a-z
    0-9
    6 characters
    */
    // how to show the server message in the ui flutter i have two files ui and code
    final data = jsonDecode(response.body);
    // Check if the request was successful
    if (response.statusCode == 201 || response.statusCode == 200) {
      final accessToken = data['data']['access'];
      final refreshToken = data['data']['refresh'];

      // Save tokens using SharedPreferences
      await Tokens.set('access_token', accessToken);
      await Tokens.set('refresh_token', refreshToken);
      print(await Tokens.retrieve('access_token'));

      print("Register successful: ${data['message'] ?? 'Welcome!'}");
      return true;
    } else {
      print(data['message'][0]);
      print("Failed to register. Status code: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Error occurred: $e");
    return false;
  }
}
