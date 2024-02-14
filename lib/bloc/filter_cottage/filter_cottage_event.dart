part of 'filter_cottage_bloc.dart';

sealed class FilterCottageEvent extends Equatable {
  const FilterCottageEvent();

  @override
  List<Object> get props => [];
}

class FilterCottage extends FilterCottageEvent {
  FilterDto dto;
  FilterCottage(this.dto);
}
