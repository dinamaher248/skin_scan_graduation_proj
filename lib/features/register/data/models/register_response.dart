class RegisterResponse {
  final bool success;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  RegisterResponse({
    required this.success,
    this.accessToken,
    this.refreshToken,
    this.message,
  });
}
