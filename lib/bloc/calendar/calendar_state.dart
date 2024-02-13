part of 'calendar_bloc.dart';

sealed class CalendarState {
  const CalendarState();
}

class CalendarUpdatedState extends CalendarState {
  final DateTime selectedDay;
  final DateTime focusedDay;

  const CalendarUpdatedState(this.selectedDay, this.focusedDay);
}
