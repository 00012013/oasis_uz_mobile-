part of 'popular_cottages_bloc_bloc.dart';

abstract class PopularCottagesBlocState {
  const PopularCottagesBlocState();
}

final class PopularCottagesBlocInitial extends PopularCottagesBlocState {}

final class PopularCottagesLoaded extends PopularCottagesBlocState {
  final List<Cottage> cottages;

  const PopularCottagesLoaded(this.cottages);
}

final class PopularCottagesLoading extends PopularCottagesBlocState {}

final class FavoriteCottagesLoaded extends PopularCottagesBlocState {
  final List<Cottage> cottages;

  const FavoriteCottagesLoaded(this.cottages);
}
