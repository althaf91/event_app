part of 'calender_bloc.dart';

abstract class CalendarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadEvents extends CalendarEvent {}

class SelectDate extends CalendarEvent {
  final DateTime selectedDay;

  SelectDate(this.selectedDay);

  @override
  List<Object> get props => [selectedDay];
}

class AddEvent extends CalendarEvent {
  final Event event;
  final DateTime date;

  AddEvent(this.event, this.date);

  @override
  List<Object> get props => [event, date];
}
