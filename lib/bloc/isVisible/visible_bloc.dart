import 'package:bloc/bloc.dart';

part 'visible_event.dart';

class VisibleBloc extends Bloc<VisibleEvent, bool> {
  VisibleBloc() : super(false) {
    on<VisibleEvent>((event, emit) {
      if (event == VisibleEvent.toggleVisibility) {
        emit(!state);
      }
    });
  }
}
