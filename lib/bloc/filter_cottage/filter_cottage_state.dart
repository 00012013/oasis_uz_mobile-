part of 'filter_cottage_bloc.dart';

sealed class FilterCottageState extends Equatable {
  const FilterCottageState();

  @override
  List<Object> get props => [];
}

final class FilterCottageInitial extends FilterCottageState {}

final class FilterCottageLoaded extends FilterCottageState {
  List<Cottage> cottage;
  FilterCottageLoaded(this.cottage);
}
