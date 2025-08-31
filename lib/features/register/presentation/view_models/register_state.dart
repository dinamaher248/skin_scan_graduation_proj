abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterValidationError extends RegisterState {
  final String? fullNameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  RegisterValidationError({
    this.fullNameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });
}

class RegisterSuccess extends RegisterState {
  final String? message;
  RegisterSuccess({this.message});
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}
