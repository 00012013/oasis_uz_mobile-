import 'package:equatable/equatable.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';

abstract class ApproveCottageState extends Equatable {
  const ApproveCottageState();

  @override
  List<Object> get props => [];
}

class ApproveCottageInitial extends ApproveCottageState {}

class ApproveCottageLoaded extends ApproveCottageState {
  final List<Cottage?> availableCottages;

  const ApproveCottageLoaded(this.availableCottages);

  @override
  List<Object> get props => [availableCottages];
}

class ApproveCottageError extends ApproveCottageState {
  final String errorMessage;

  const ApproveCottageError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
