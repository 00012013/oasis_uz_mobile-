import 'package:bloc/bloc.dart';
import 'package:oasis_uz_mobile/repositories/authentication_repository.dart';
import 'package:oasis_uz_mobile/repositories/enums/auth_enum.dart';

class AuthenticationCubit extends Cubit<AuthenticationStatus> {
  AuthenticationCubit(this._authenticationRepository)
      : super(AuthenticationStatus.unauthenticated);

  final AuthenticationRepository _authenticationRepository;

  Future<void> authenticateUser(String username, String password) async {
    final accessToken =
        await _authenticationRepository.authenticateUser(username, password);
    if (accessToken != null) {
      emit(AuthenticationStatus.authenticated);
    } else {
      emit(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> checkAuthenticationStatus() async {
    final token = await _authenticationRepository.retrieveToken();
    if (token != null) {
      emit(AuthenticationStatus.authenticated);
    } else {
      emit(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logout() async {
    await _authenticationRepository.logout();
    emit(AuthenticationStatus.unauthenticated);
  }
}
