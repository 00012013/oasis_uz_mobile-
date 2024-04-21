import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oasis_uz_mobile/bloc/authentication/authentication_state.dart';
import 'package:oasis_uz_mobile/constants/api_constants.dart';
import 'package:oasis_uz_mobile/repositories/authentication_repository.dart';
import 'package:oasis_uz_mobile/repositories/enums/auth_enum.dart';
import 'package:oasis_uz_mobile/repositories/models/user.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._authenticationRepository)
      : super(AuthenticationInitial());

  static UserRole currentUserRole = UserRole.USER;

  final AuthenticationRepository _authenticationRepository;

  Future<void> initialize() async {
    final User? user = await _authenticationRepository.checkAuth();
    if (user != null) {
      if (user.role == UserRole.ADMIN) {
        currentUserRole = UserRole.ADMIN;
      }
      emit(AuthenticationSuccess(user));
    } else {
      emit(const AuthenticationFailure(''));
    }
  }

  Future<void> authenticateUser(String username, String password) async {
    final user =
        await _authenticationRepository.authenticateUser(username, password);
    if (user != null) {
      if (user.role == UserRole.ADMIN) {
        currentUserRole = UserRole.ADMIN;
      }
      emit(AuthenticationSuccess(user));
    } else {
      emit(const AuthenticationFailure('Failed authenticate user!'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? account =
          await GoogleSignIn(serverClientId: clientId).signIn();
      final GoogleSignInAuthentication authentication =
          await account!.authentication;
      final String? idToken = authentication.idToken;

      var user =
          await _authenticationRepository.authenticateWithGoogle(idToken);

      if (user != null) {
        emit(AuthenticationSuccess(user));
      } else {
        emit(const AuthenticationFailure(
            'This username already exists! Please login without google!'));
      }
    } catch (error) {
      emit(const AuthenticationFailure('Error signing in with Google!'));
    }
  }

  Future<void> checkAuthenticationStatus() async {
    final token = await _authenticationRepository.retrieveToken();
    if (token == null) {
      emit(const AuthenticationFailure(''));
    }
  }

  void emitInitial() {
    emit(AuthenticationInitial());
  }

  Future<void> logout() async {
    await _authenticationRepository.logout();
    emit(LogoutState());
  }

  Future<void> registerUser(User user) async {
    var registerUser = await _authenticationRepository.registerUser(user);
    if (registerUser == null) {
      emit(RegistrationSuccess());
    } else {
      emit(RegistrationFailure(registerUser));
    }
  }

  Future<User> getUser() async {
    final User? user = await _authenticationRepository.checkAuth();

    return user!;
  }
}
