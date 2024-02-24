import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/modules/filter.dart';
import 'package:oasis_uz_mobile/repositories/modules/cottage.dart';
import 'package:oasis_uz_mobile/util/shared_preferences.dart';

part 'filter_cottage_event.dart';
part 'filter_cottage_state.dart';

class FilterCottageBloc extends Bloc<FilterCottageEvent, FilterCottageState> {
  final CottageRepository cottageRepository;
  final List<Cottage> cottageList = [];

  late StreamSubscription subscription;

  FilterCottageBloc(this.cottageRepository) : super(FilterCottageInitial()) {
    on<FilterCottageEvent>(
      (event, emit) async {
        if (event is FilterCottage) {
          Set<int>? loadFavoriteCottageId =
              await SharedPreferencesHelper.loadFavoriteCottageIds();
          if (event.dto == null) {
            if (loadFavoriteCottageId != null &&
                loadFavoriteCottageId.isNotEmpty) {
              var favCottages = SharedPreferencesHelper.changeFavorite(
                  cottageList, loadFavoriteCottageId);
              emit(FilterCottageLoaded(favCottages.toList()));
              return;
            } else {
              var favCottages =
                  SharedPreferencesHelper.changeFavorite(cottageList, null);
              emit(FilterCottageLoaded(favCottages.toList()));
              return;
            }
          }

          final List<Cottage> cottages =
              await cottageRepository.fetchFilteredCottages(event.dto!);
          if (cottageList.isNotEmpty) {
            cottageList.removeRange(0, cottageList.length);
          }
          cottageList.addAll(cottages);
          if (loadFavoriteCottageId != null &&
              loadFavoriteCottageId.isNotEmpty) {
            var favCottages = SharedPreferencesHelper.changeFavorite(
                cottages, loadFavoriteCottageId);

            emit(FilterCottageLoaded(favCottages));
            return;
          }

          emit(FilterCottageLoaded(cottages));
        } else if (event is FilterCottageEvents) {
          emit(FilterCottageLoading());
        }
      },
    );
  }
}
