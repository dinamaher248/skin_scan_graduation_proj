// infection_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Mapping/mapping_upload.dart';
import '../../../../core/helper/token.dart';
import '../../../../core/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'infection_state.dart';

class InfectionCubit extends Cubit<InfectionState> {
  InfectionCubit() : super(InfectionInitial());

  Future<void> getDetails(int id) async {
    emit(InfectionLoading());
    try {
      final url = Uri.parse("$resourceUrl/api/Wound/get-id?id=$id");
      final token = await Tokens.retrieve('access_token');

      final headers = {"Authorization": "Bearer $token"};
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = MappingUpload(responseJson: jsonResponse);
        emit(InfectionLoaded(data));
      } else {
        emit(InfectionError("Failed to load data: ${response.statusCode}"));
      }
    } catch (e) {
      emit(InfectionError("Error occurred: $e"));
    }
  }
}
