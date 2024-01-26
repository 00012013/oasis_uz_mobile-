part of 'popular_cottages_bloc_bloc.dart';

abstract class PopularCottagesBlocEvent {
  const PopularCottagesBlocEvent();
}

class FetchPopularCottageEvent extends PopularCottagesBlocEvent {}

class ToggleFavoriteEvent extends PopularCottagesBlocEvent {
  final int cottageId;

  const ToggleFavoriteEvent(this.cottageId);
}

class FetchFavoriteCottageEvent extends PopularCottagesBlocEvent {}
