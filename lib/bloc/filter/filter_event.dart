part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

enum FilterTypeOption { latest, cheapest, mostExpensive }

class FilterTypeSelected extends FilterEvent {
  final FilterTypeOption selectedOption;

  const FilterTypeSelected(this.selectedOption);

  @override
  List<Object> get props => [selectedOption];
}
