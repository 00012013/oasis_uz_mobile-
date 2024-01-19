part of 'carousel_slider_bloc.dart';

@immutable
abstract class CarouselSliderEvent {
  const CarouselSliderEvent();
}

class CarouselIndexChanged extends CarouselSliderEvent {
  final int newIndex;

  const CarouselIndexChanged(this.newIndex);
}
