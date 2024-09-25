import 'dart:async';
import 'dart:math';

import 'package:event_app/presentation/widgets/create_event_sheet.dart';
import 'package:event_app/presentation/widgets/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/model/event.dart';
import '../widgets/category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusDay = DateTime.now();
  DateTime? _selectedDay;
  //store the events
  Map<String, List<Event>> events = {};

  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusDay) {
    if (!isSameDay(_selectedDay, selectedDay)) ;
    setState(() {
      _selectedDay = selectedDay;
      _focusDay = focusDay;
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  Widget _buildEventMarker(String type,double size) {
    switch (type) {
      case 'brainstorm':
        return SvgPicture.asset(
          'assets/images/oval2.svg', // Replace with your SVG file name
          width: size, // Set width
          height: size,
          colorFilter: ColorFilter.mode(
              Color(0xFF735BF2), BlendMode.srcIn), // Set height
        );
      case 'design':
        return SvgPicture.asset(
          'assets/images/oval2.svg', // Replace with your SVG file name
          width: size, // Set width
          height: size,
          colorFilter: ColorFilter.mode(
              Color(0xFF00B383), BlendMode.srcIn), // Set height
        );
      case 'workout':
        return SvgPicture.asset(
          'assets/images/oval2.svg', // Replace with your SVG file name
          width: size, // Set width
          height: size,
          colorFilter: ColorFilter.mode(
              Color(0xFF0095FF), BlendMode.srcIn), // Set height
        );
      default:
        return SvgPicture.asset(
          'assets/images/oval2.svg', // Replace with your SVG file name
          width: size, // Set width
          height: size,
          colorFilter: ColorFilter.mode(
              Color(0xFF0095FF), BlendMode.srcIn), // Set height
        );
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    String date = DateFormat('yyyy-MM-dd').format(day);
    return events[date] ?? [];
  }

  showAddEvent(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              top: 30,
              left: 15,
              right: 15),
          child: CreateEventSheet(onEventCreated: (event) {
            if (events[event.date] != null) {
              events[event.date]!.add(event);
            } else {
              events[event.date] = [event];
            }

            setState(() {
              _selectedEvents.value = _getEventsForDay(_selectedDay!);
            });



            Navigator.of(context).pop();
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextFormatter: (date, locale) => DateFormat('MMMM  \n yyyy').format(date),
                  titleCentered:true,
              ),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: _getEventsForDay,
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, date, _) {
              return Center(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFF735BF2), // Background color for selected date
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                // Cast the events to List<Event>
                List<Event> typedEvents = events.cast<Event>();
                return Container(
                  margin: const EdgeInsets.only(top:27),
                  padding: const EdgeInsets.only(top:17),
                  width: 22,
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 1.0, // Space between markers
                    runSpacing: 1.0, // Space between lines
                    children: typedEvents.take(6).map((event) {
                      return _buildEventMarker(event.category!,6);
                    }).toList(),
                  ),
                );
              }
              return Container();
            },
          ),
                calendarFormat: CalendarFormat.month,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2101, 12, 31),
                focusedDay: _selectedDay!),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        _buildEventMarker(value[index].category!,10),
                                        SizedBox(width: 5),
                                        Text('${value[index].startTime.format(context)} - ${value[index].endTime.format(context)}',
                                          style: TextStyle(
                                              fontFamily: 'SFUIText',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color:Colors.grey[400]
                                          )),
                                      ],
                                    ),
                                    Icon(
                                      size:24,
                                      Icons.more_horiz,
                                    color: Colors.grey.shade400,)
                                  ],
                                ),
                                Text(value[index].title,style: TextStyle(
                                    fontFamily: 'SFUIText',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                ),),
                                Text(value[index].description,style: TextStyle(
                                    fontFamily: 'SFUIText',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:Colors.grey[400]
                                ),)
                              ],
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEvent(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: const Color(0xFF735BF2),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                'assets/images/event.svg', // Replace with your SVG file name
                width: 24, // Set width
                height: 24, // Set height
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/images/time.svg', // Replace with your SVG file name
                width: 24, // Set width
                height: 24, // Set height
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/images/notification.svg',
                // Replace with your SVG file name
                width: 24, // Set width
                height: 24, // Set height
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/images/user.svg', // Replace with your SVG file name
                width: 24, // Set width
                height: 24, // Set height
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
