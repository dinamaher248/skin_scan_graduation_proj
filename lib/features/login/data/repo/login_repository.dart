import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/helper/token.dart';
import '../../../../core/utils/constants.dart';
import '../models/login_response_model.dart';

class LoginRepository {
  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse("$apiUrl/api/Auth/auth/login");

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"email": email, "password": password});

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['state'] == true) {
        final accessToken = data['data']['access']?.toString();
        final refreshToken = data['data']['refresh']?.toString();

        await Tokens.set('access_token', accessToken!);
        await Tokens.set('refresh_token', refreshToken!);
      print("Login successful: ${data['message'] ?? 'Welcome!'}");

        final message = (data['message'] is List)
            ? (data['message'] as List).join(", ")
            : data['message'].toString();

        return LoginResponse(
          success: true,
          accessToken: accessToken,
          refreshToken: refreshToken,
          message: message,
        );
      } else {
        final message = (data['message'] is List)
            ? (data['message'] as List).join(", ")
            : data['message'].toString();

        return LoginResponse(
          success: false,
          message: message,
        );
      }
    } catch (e) {
      return LoginResponse(
        success: false,
        message: "Error occurred: $e",
      );
    }
  }
}
