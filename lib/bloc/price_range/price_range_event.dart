part of 'price_range_bloc.dart';

sealed class PriceRangeEvent extends Equatable {
  const PriceRangeEvent();

  @override
  List<Object> get props => [];
}

class PriceRangeUpdated extends PriceRangeEvent {
  final double minPrice;
  final double maxPrice;

  const PriceRangeUpdated(this.minPrice, this.maxPrice);

  @override
  List<Object> get props => [minPrice, maxPrice];
}
