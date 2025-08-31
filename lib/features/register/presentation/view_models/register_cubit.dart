import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/register_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository repository;

  RegisterCubit(this.repository) : super(RegisterInitial());

  Future<void> register(String fullName, String email, String password, String confirmPassword) async {
    emit(RegisterLoading());

    String? fullNameError;
    String? emailError;
    String? passwordError;
    String? confirmPasswordError;

    if (fullName.isEmpty) fullNameError = "Full name is required";
    if (!_isValidEmail(email)) emailError = "Please enter a valid email";
    if (password.length < 6) passwordError = "Password must be at least 6 characters";
    if (password != confirmPassword) confirmPasswordError = "Passwords doesn't match";

    if (fullNameError != null || emailError != null || passwordError != null || confirmPasswordError != null) {
      emit(RegisterValidationError(
        fullNameError: fullNameError,
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      ));
      return;
    }

    final response = await repository.register(fullName, email, password, confirmPassword);

    if (response.success) {
      emit(RegisterSuccess(message: response.message));
    } else {
      emit(RegisterError(response.message ?? "Registration failed"));
    }
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
}
