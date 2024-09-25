import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final String date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool remindMe;
  String? category;

  Event(this.title, this.description,this.date, this.startTime, this.endTime,
      this.remindMe, this.category);

  @override
  String toString() =>  '${title}   ${date}';
}