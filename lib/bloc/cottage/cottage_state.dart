part of 'cottage_bloc.dart';

@immutable
abstract class CottageState {
  const CottageState();
}

final class CottageInitial extends CottageState {}

class CottagesLoaded extends CottageState {
  final List<AppBannerImages> cottages;

  const CottagesLoaded(this.cottages);
}
