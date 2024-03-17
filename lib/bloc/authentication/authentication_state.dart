import 'package:oasis_uz_mobile/repositories/modules/user.dart';

abstract class AuthenticationState {
  const AuthenticationState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationState &&
          runtimeType == other.runtimeType &&
          _propsEquals(other);

  bool _propsEquals(AuthenticationState other) => true;

  @override
  int get hashCode => runtimeType.hashCode;
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User? user;

  const AuthenticationSuccess(this.user);

  @override
  bool _propsEquals(AuthenticationState other) =>
      other is AuthenticationSuccess && other.user == user;
}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationFailure &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  bool _propsEquals(AuthenticationState other) =>
      other is AuthenticationFailure && other.error == error;
  @override
  int get hashCode => error.hashCode;
}

class RegistrationSuccess extends AuthenticationState {}

class RegistrationFailure extends AuthenticationState {
  final String error;

  const RegistrationFailure(this.error);

  @override
  bool _propsEquals(AuthenticationState other) =>
      other is RegistrationFailure && other.error == error;
}

class LogoutState extends AuthenticationState {}
