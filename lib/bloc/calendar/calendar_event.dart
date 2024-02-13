part of 'calendar_bloc.dart';

sealed class CalendarEvent {
  const CalendarEvent();
}

class UpdateSelectedDayEvent extends CalendarEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  const UpdateSelectedDayEvent(this.selectedDay, this.focusedDay);
}
