import 'package:bloc/bloc.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/modules/cottage.dart';

part 'popular_cottages_bloc_event.dart';
part 'popular_cottages_bloc_state.dart';

class PopularCottagesBlocBloc
    extends Bloc<PopularCottagesBlocEvent, PopularCottagesBlocState> {
  final CottageRepository cottageRepository;

  PopularCottagesBlocBloc(this.cottageRepository)
      : super(PopularCottagesBlocInitial()) {
    on<PopularCottagesBlocEvent>(
      (event, emit) async {
        if (event is FetchPopularCottageEvent) {
          try {
            final List<Cottage> cottages =
                await cottageRepository.fetchPopulaarCottages();
            emit(PopularCottagesLoaded(cottages));
          } catch (e) {
            throw Exception(e);
          }
        }
      },
    );
  }
}
