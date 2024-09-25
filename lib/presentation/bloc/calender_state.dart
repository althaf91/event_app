part of 'calender_bloc.dart';


class CalendarState extends Equatable {
  final DateTime selectedDay;
  final Map<DateTime, List<Event>> events;

  CalendarState({required this.selectedDay, required this.events});

  @override
  List<Object> get props => [selectedDay, events];
}
