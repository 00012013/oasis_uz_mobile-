part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {
  final int tabIndex;
  const NavigationState(this.tabIndex);
}

class NavigationInitial extends NavigationState {
  const NavigationInitial(super.tabIndex);
}
