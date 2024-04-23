part of 'user_cottages_cubit.dart';

sealed class UserCottagesState extends Equatable {
  const UserCottagesState();

  @override
  List<Object> get props => [];
}

final class UserCottagesInitial extends UserCottagesState {}

final class UserCottagesLoaded extends UserCottagesState {
  final List<Cottage?> cottages;

  const UserCottagesLoaded(this.cottages);
}

final class UserCottagesException extends UserCottagesState {
  final String message;

  const UserCottagesException(this.message);
}
