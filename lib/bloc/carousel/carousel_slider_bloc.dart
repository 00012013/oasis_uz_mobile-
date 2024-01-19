import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'carousel_slider_event.dart';
part 'carousel_slider_state.dart';

class CarouselSliderBloc
    extends Bloc<CarouselSliderEvent, CarouselSlidersState> {
  CarouselSliderBloc() : super(const CarouselIndexUpdated(0)) {
    on<CarouselSliderEvent>((event, emit) {
      if (event is CarouselIndexChanged) {
        emit(CarouselIndexUpdated(event.newIndex));
      }
    });
  }
}
