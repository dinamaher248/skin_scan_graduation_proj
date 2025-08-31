abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginValidationError extends LoginState {
  final String? emailError;
  final String? passwordError;
  LoginValidationError({this.emailError, this.passwordError});
}
