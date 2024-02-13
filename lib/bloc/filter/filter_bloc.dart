import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {
      if (event is FilterTypeSelected) {
        if (event.selectedOption == FilterTypeOption.latest) {
          emit(FilterByLatestSelected());
        } else if (event.selectedOption == FilterTypeOption.cheapest) {
          emit(FilterByCheapestSelected());
        } else if (event.selectedOption == FilterTypeOption.mostExpensive) {
          emit(FilterByMostExpensiveSelected());
        }
      }
    });
  }
}
