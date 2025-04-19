import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;
import '../helper/token.dart';
import 'constants.dart';

Future<bool> doctorRegisterApi(
    String? phone, String? location, String? Education, String? Fees) async {
  final url = Uri.parse(apiUrl + "");

  final headers = {
    "Content-Type": "application/json",
  };

  final body = jsonEncode({
    "phone": phone,
    "location": location,
    "Education": Education,
    "Fees": Fees,
  });

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

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
