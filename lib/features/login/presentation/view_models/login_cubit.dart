import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    String? emailError;
    String? passwordError;

    if (!_isValidEmail(email)) {
      emailError = "Please enter a valid email";
    }
    if (password.length < 6) {
      passwordError = "Password must be at least 6 characters long";
    }

    if (emailError != null || passwordError != null) {
      emit(LoginValidationError(emailError: emailError, passwordError: passwordError));
      return;
    }

    final response = await repository.login(email, password);

    if (response.success) {
      emit(LoginSuccess());
    } else {
      emit(LoginError(response.message ?? "Login failed, please try again"));
    }
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
}
