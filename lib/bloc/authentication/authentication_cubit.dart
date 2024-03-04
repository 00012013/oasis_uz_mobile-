import 'package:bloc/bloc.dart';
import 'package:oasis_uz_mobile/repositories/authentication_repository.dart';
import 'package:oasis_uz_mobile/repositories/modules/user.dart';

class AuthenticationCubit extends Cubit<User?> {
  AuthenticationCubit(this._authenticationRepository) : super(null) {
    initialize();
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> initialize() async {
    final User? user = await _authenticationRepository.checkAuth();
    if (user != null) {
      emit(user);
    }
  }

  Future<void> authenticateUser(String username, String password) async {
    final user =
        await _authenticationRepository.authenticateUser(username, password);
    await _authenticationRepository.saveUser(user);
    if (user != null) {
      emit(user);
    } else {
      emit(null);
    }
  }

  Future<void> checkAuthenticationStatus() async {
    final token = await _authenticationRepository.retrieveToken();
    if (token == null) {
      emit(null);
    }
  }

  Future<void> logout() async {
    await _authenticationRepository.logout();
    emit(null);
  }
}
