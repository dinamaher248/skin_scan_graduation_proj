import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/helper/token.dart';
import '../../../../core/utils/constants.dart';
import '../models/register_response.dart';

class RegisterRepository {
  Future<RegisterResponse> register(
      String fullName, String email, String password, String confirmPassword) async {
    final url = Uri.parse("$apiUrl/api/Auth/auth/register");

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "fullName": fullName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      final message = (data['message'] is List)
          ? (data['message'] as List).join(", ")
          : data['message'].toString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final accessToken = data['data']['access'];
        final refreshToken = data['data']['refresh'];

        await Tokens.set('access_token', accessToken);
        await Tokens.set('refresh_token', refreshToken);

        return RegisterResponse(
          success: true,
          accessToken: accessToken,
          refreshToken: refreshToken,
          message: message,
        );
      } else {
        return RegisterResponse(success: false, message: message);
      }
    } catch (e) {
      return RegisterResponse(success: false, message: "Error: $e");
    }
  }
}
