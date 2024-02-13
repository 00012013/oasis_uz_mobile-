part of 'price_range_bloc.dart';

sealed class PriceRangeState extends Equatable {
  const PriceRangeState();

  @override
  List<Object> get props => [];
}

class PriceRangeFiltered extends PriceRangeState {
  final double minPrice;
  final double maxPrice;

  const PriceRangeFiltered(this.minPrice, this.maxPrice);

  @override
  List<Object> get props => [minPrice, maxPrice];
}
