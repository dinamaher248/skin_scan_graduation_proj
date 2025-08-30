// infection_state.dart
part of 'infection_cubit.dart';

abstract class InfectionState {}

class InfectionInitial extends InfectionState {}

class InfectionLoading extends InfectionState {}

class InfectionLoaded extends InfectionState {
  final MappingUpload data;
  InfectionLoaded(this.data);
}

class InfectionError extends InfectionState {
  final String message;
  InfectionError(this.message);
}
