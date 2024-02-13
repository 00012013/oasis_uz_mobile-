part of 'filter_bloc.dart';

sealed class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

final class FilterInitial extends FilterState {}

class FilterByLatestSelected extends FilterState {}

class FilterByCheapestSelected extends FilterState {}

class FilterByMostExpensiveSelected extends FilterState {}
