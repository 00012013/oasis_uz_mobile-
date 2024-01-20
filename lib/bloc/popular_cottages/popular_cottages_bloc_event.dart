part of 'popular_cottages_bloc_bloc.dart';

sealed class PopularCottagesBlocEvent {
  const PopularCottagesBlocEvent();
}

class FetchPopularCottageEvent extends PopularCottagesBlocEvent {}
