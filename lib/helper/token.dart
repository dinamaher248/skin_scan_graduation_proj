import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tokens {
  // Retrieve a token
  static Future<String?> retrieve(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Set a token
  static Future<void> set(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  static Future<bool> isExpired(token) async {
    if (token == null) return true;

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    final chkTime = DateTime.now().microsecondsSinceEpoch / 1000;
    return chkTime > decodedToken['exp'];
  }

  // get the username from token
  static Future<String> getName(token) async {
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken["sub"];
    }
    return "null";
  }

  static Future<String> getId(token) async {
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['uid'];
    }
    return "null";
  }

  static Future<String> getRole(token) async {
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      if (decodedToken['roles'] != null) return decodedToken['roles'];
    }
    return "";
  }
}
