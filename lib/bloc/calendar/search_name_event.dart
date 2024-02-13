part of 'search_name_bloc.dart';

abstract class SearchNameEvent {
  const SearchNameEvent();
}

class SearchTextNameChanged extends SearchNameEvent {
  final String searchTerm;

  SearchTextNameChanged(this.searchTerm);
}
