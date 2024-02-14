import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_range_event.dart';
part 'price_range_state.dart';

class PriceRangeBloc extends Bloc<PriceRangeEvent, PriceRangeState> {
  PriceRangeBloc() : super(const PriceRangeFiltered(0, 10000000)) {
    on<PriceRangeUpdated>((event, emit) {
      emit(PriceRangeFiltered(event.minPrice, event.maxPrice));
    });
  }
}
