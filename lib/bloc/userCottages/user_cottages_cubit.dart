import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_cubit.dart';
import 'package:oasis_uz_mobile/repositories/authentication_repository.dart';
import 'package:oasis_uz_mobile/repositories/cottage_repository.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';

part 'user_cottages_state.dart';

class UserCottagesCubit extends Cubit<UserCottagesState> {
  UserCottagesCubit() : super(UserCottagesInitial()) {
    _fetchUserCottages();
  }

  final AuthenticationCubit _authenticationCubit =
      AuthenticationCubit(AuthenticationRepository());

  final CottageRepository _cottageRepository = CottageRepository();

  Future<void> _fetchUserCottages() async {
    try {
      var user = await _authenticationCubit.getUser();

      final List<Cottage?> availableCottages =
          await _cottageRepository.getUserCottages(user.id!);

      emit(UserCottagesLoaded(availableCottages));
    } catch (error) {
      emit(UserCottagesException(error.toString()));
    }
  }
}
