import 'package:bloc/bloc.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'popular_cottages_bloc_event.dart';
part 'popular_cottages_bloc_state.dart';

class PopularCottagesBlocBloc
    extends Bloc<PopularCottagesBlocEvent, PopularCottagesBlocState> {
  final CottageRepository cottageRepository;
  final String favoriteCottageIdsKey = 'favoriteCottageIds';
  List<int> favoriteCottageIds = [];

  PopularCottagesBlocBloc(this.cottageRepository)
      : super(PopularCottagesBlocInitial()) {
    on<PopularCottagesBlocEvent>(
      (event, emit) async {
        if (event is FetchPopularCottageEvent) {
          try {
            final List<Cottage> cottages =
                await cottageRepository.fetchPopulaarCottages();
            Set<int>? loadFavoriteCottageId = await loadFavoriteCottageIds();

            if (loadFavoriteCottageId != null &&
                loadFavoriteCottageId.isNotEmpty) {
              var favCottages = changeFavorite(cottages, loadFavoriteCottageId);
              favoriteCottageIds.addAll(loadFavoriteCottageId);
              emit(PopularCottagesLoaded(favCottages));
              return;
            }

            emit(PopularCottagesLoaded(cottages));
          } catch (e) {
            throw Exception(e);
          }
        } else if (event is ToggleFavoriteEvent) {
          List<Cottage> updatedCottages =
              List.from((state as PopularCottagesLoaded).cottages);

          Cottage cottageToUpdate = updatedCottages.firstWhere(
            (cottage) => cottage.id == event.cottageId,
            orElse: () => Cottage(id: event.cottageId),
          );

          cottageToUpdate.isFavorite = !cottageToUpdate.isFavorite;

          int indexToUpdate = updatedCottages.indexOf(cottageToUpdate);
          updatedCottages[indexToUpdate] = cottageToUpdate;

          if (cottageToUpdate.isFavorite) {
            favoriteCottageIds.add(event.cottageId);
          } else {
            favoriteCottageIds.remove(event.cottageId);
          }

          saveFavoriteCottageIds();

          emit(PopularCottagesLoaded(updatedCottages));
        }
      },
    );
  }
  Future<Set<int>?> loadFavoriteCottageIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<int>? storedIds = prefs
        .getStringList(favoriteCottageIdsKey)
        ?.map((id) => int.parse(id))
        .toSet();
    return storedIds;
  }

  List<Cottage> changeFavorite(
      List<Cottage> cottageList, Set<int> favoriteList) {
    for (int favorite in favoriteList) {
      for (Cottage cottage in cottageList) {
        if (cottage.id == favorite) {
          cottage.isFavorite = true;
          break;
        }
      }
    }
    return cottageList;
  }

  Future<void> saveFavoriteCottageIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoriteCottageIdsKey,
        favoriteCottageIds.map((id) => id.toString()).toList());
  }
}
