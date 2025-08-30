import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Mapping/mapping_upload.dart';
import '../../data/repo/result_repo.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  final ResultRepository repository;
  String? uploadURL;
  String? selectedValue;

  ResultCubit(this.repository) : super(ResultInitial());

  void selectModel(String value) {
    selectedValue = value;
    switch (value) {
      case 'Type':
        uploadURL = "/api/Wound/upload-type";
        break;
      case 'Burn':
        uploadURL = "/api/Wound/upload-burn";
        break;
      case 'Skin disease':
        uploadURL = "/api/Wound/upload-skin";
        break;
    }
    emit(ResultModelSelected(selectedValue!));
  }

  Future<void> processImage(String imagePath) async {
    if (selectedValue == null || uploadURL == null) {
      emit(ResultError("Please select a model before analyzing image"));
      return;
    }
    emit(ResultLoading());
    try {
      final upload = await repository.processImage(imagePath, uploadURL!);
      emit(ResultLoaded(upload));
    } catch (e) {
      emit(ResultError("Error processing image: $e"));
    }
  }
}
