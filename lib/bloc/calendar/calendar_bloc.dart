import 'package:bloc/bloc.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarUpdatedState(DateTime.now(), DateTime.now())) {
    on<CalendarEvent>((event, emit) {
      if (event is UpdateSelectedDayEvent) {
        emit(CalendarUpdatedState(event.selectedDay, event.focusedDay));
      }
    });
  }
}
