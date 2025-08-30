part of 'result_cubit.dart';

abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoaded extends ResultState {
  final MappingUpload upload;
  ResultLoaded(this.upload);
}

class ResultModelSelected extends ResultState {
  final String selectedModel;
  ResultModelSelected(this.selectedModel);
}

class ResultError extends ResultState {
  final String message;
  ResultError(this.message);
}
