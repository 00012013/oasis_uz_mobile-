part of 'filter_cottage_bloc.dart';

sealed class FilterCottageEvent extends Equatable {
  const FilterCottageEvent();
  @override
  List<Object> get props => [];
}

class FilterCottageEvents extends FilterCottageEvent {}

class FilterCottage extends FilterCottageEvent {
  final Filter? dto;
  const FilterCottage(this.dto);
}
