part of 'carousel_slider_bloc.dart';

@immutable
abstract class CarouselSlidersState {
  const CarouselSlidersState();
}

class CarouselIndexUpdated extends CarouselSlidersState {
  final int currentIndex;

  const CarouselIndexUpdated(
    this.currentIndex,
  );
}
