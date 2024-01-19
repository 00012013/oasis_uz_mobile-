part of 'cottage_bloc.dart';

@immutable
abstract class CottageState {
  const CottageState();
}

final class CottageInitial extends CottageState {}

final class CottageLoading extends CottageState {}

class CottagesLoaded extends CottageState {
  final List<Cottage> cottages;

  const CottagesLoaded(this.cottages);
}
