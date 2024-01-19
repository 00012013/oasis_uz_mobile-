import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial(0)) {
    on<NavigationEvent>((event, emit) async {
      if (event is TabChange) {
        emit(NavigationInitial(event.tabIndex));
      }
    });
  }
}
