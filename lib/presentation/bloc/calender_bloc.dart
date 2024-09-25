import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/event.dart';

part 'calender_event.dart';
part 'calender_state.dart';

class CalenderBloc extends Bloc<CalendarEvent,CalendarState> {
  CalenderBloc() : super(CalendarState(selectedDay: DateTime.now(), events: {})) {
    on<CalendarEvent>((event,emit) {
      if(event is SelectDate) {
        emit(CalendarState(selectedDay: event.selectedDay, events: state.events));
      }
      if(event is AddEvent) {
        final updatedEvents = Map<DateTime, List<Event>>.from(state.events);
        if (updatedEvents[event.date] != null) {
          updatedEvents[event.date]!.add(event.event);
        } else {
          updatedEvents[event.date] = [event.event];
        }
        emit(CalendarState(
          selectedDay: state.selectedDay,
          events: updatedEvents,
        ));
      }
    });
  }
}


