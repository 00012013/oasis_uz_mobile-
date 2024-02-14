import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/dto/filter_dto.dart';
import 'package:oasis_uz_mobile/repositories/modules/cottage.dart';

part 'filter_cottage_event.dart';
part 'filter_cottage_state.dart';

class FilterCottageBloc extends Bloc<FilterCottageEvent, FilterCottageState> {
  final CottageRepository cottageRepository;

  FilterCottageBloc(this.cottageRepository) : super(FilterCottageInitial()) {
    on<FilterCottageEvent>(
      (event, emit) async {
        if (event is FilterCottage) {
          final List<Cottage> cottages =
              await cottageRepository.fetchFilteredCottages(event.dto);
          emit(FilterCottageLoaded(cottages));
        }
      },
    );
  }
}
