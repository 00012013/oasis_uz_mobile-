part of 'filter_cottage_bloc.dart';

sealed class FilterCottageState extends Equatable {
  const FilterCottageState();

  @override
  List<Object> get props => [];
}

final class FilterCottageInitial extends FilterCottageState {}

final class FilterCottageLoading extends FilterCottageState {}

final class FilterCottageLoaded extends FilterCottageState {
  final List<Cottage> cottage;
  const FilterCottageLoaded(this.cottage);

  @override
  List<Object> get props => [cottage];
  FilterCottageLoaded copyWith({
    List<Cottage>? newCottage,
  }) {
    return FilterCottageLoaded(
      newCottage ?? this.cottage,
    );
  }
}

class SearchLoadedState extends FilterCottageState {
  final List<Cottage> cottage;

  const SearchLoadedState(this.cottage);

  FilterCottageLoaded copyWith({
    List<Cottage>? cottage,
  }) {
    return FilterCottageLoaded(
      cottage ?? this.cottage,
    );
  }
}
