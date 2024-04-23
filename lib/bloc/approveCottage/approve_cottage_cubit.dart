import 'package:bloc/bloc.dart';
import 'package:oasis_uz_mobile/bloc/approveCottage/approve_cottage_state.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/repositories/authentication_repository.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';

class ApproveCottageCubit extends Cubit<ApproveCottageState> {
  final CottageRepository _cottageRepository = CottageRepository();
  final AuthenticationCubit _authenticationCubit =
      AuthenticationCubit(AuthenticationRepository());
  ApproveCottageCubit() : super(ApproveCottageInitial()) {
    _fetchAvailableCottages();
  }

  Future<void> _fetchAvailableCottages() async {
    try {
      var user = await _authenticationCubit.getUser();

      final List<Cottage?> availableCottages =
          await _cottageRepository.getPendingCottages(user.id!);

      emit(ApproveCottageLoaded(availableCottages));
    } catch (error) {
      emit(ApproveCottageError(error.toString()));
    }
  }

  Future<void> changeStatus(Cottage cottage) async {
    try {
      var user = await _authenticationCubit.getUser();

      await _cottageRepository.changeStatus(cottage, user.id!);

      var availableCottages = removeChangedStatus(cottage);

      emit(ApproveCottageLoaded(availableCottages));
    } catch (error) {
      emit(ApproveCottageError(error.toString()));
    }
  }

  List<Cottage?> removeChangedStatus(Cottage cottage) {
    if (state is ApproveCottageLoaded) {
      final currentState = state as ApproveCottageLoaded;

      final List<Cottage> currentCottages =
          List.from(currentState.availableCottages);

      currentCottages.removeWhere((c) => c.id == cottage.id);

      return currentCottages;
    }
    return [];
  }
}
