import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/helper/token.dart';
import '../../data/models/feedback_model.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());

  Future<void> submitFeedback(FeedbackModel model) async {
    emit(FeedbackLoading());

    final url = Uri.parse('$resourceUrl/api/FeedBack/add');
    String? token = await Tokens.retrieve('access_token');

    final headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        emit(FeedbackSuccess());
      } else {
        final errorRes = jsonDecode(response.body);
        emit(FeedbackError(message: errorRes['User'] ?? 'Unknown error'));
      }
    } catch (error) {
      emit(FeedbackError(message: error.toString()));
    }
  }
}
