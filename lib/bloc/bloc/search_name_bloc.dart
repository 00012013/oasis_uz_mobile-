import 'package:bloc/bloc.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';

part 'search_name_event.dart';
part 'search_name_state.dart';

class SearchNameBloc extends Bloc<SearchNameEvent, SearchNameState> {
  final CottageRepository cottageRepository;

  SearchNameBloc(this.cottageRepository) : super(SearchNameInitial()) {
    on<SearchNameEvent>((event, emit) async {
      if (event is SearchTextNameChanged) {
        try {
          List<String> cottageName =
              await cottageRepository.fetchCottageNameByName(event.searchTerm);
          emit(SearchLoadedState(cottageName));
        } catch (e) {
          emit(SearchErrorState('Error searching: $e'));
        }
      }
    });
  }
}
