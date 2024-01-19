part of 'cottage_bloc.dart';

@immutable
abstract class CottageEvent {
  const CottageEvent();
}

class FetchCottageEvent extends CottageEvent {}
