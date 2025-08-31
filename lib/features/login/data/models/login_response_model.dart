class LoginResponse {
  final bool success;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  LoginResponse({
    required this.success,
    this.accessToken,
    this.refreshToken,
    this.message,
  });
}
