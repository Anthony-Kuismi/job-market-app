import 'dart:collection';
import 'dart:developer';

import 'package:job_market_app/service/firestore_service.dart';
import 'package:table_calendar/table_calendar.dart';

import 'application.dart';

class Calendar {
  DateTime? focusedDay;
  DateTime? selectedDay;
  CalendarFormat calendarFormat=CalendarFormat.month;
  LinkedHashMap<DateTime,List<Event>> events;
  FirestoreService firestore = FirestoreService();

  DateTime? rangeStart;
  DateTime? rangeEnd;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;
  List<Event> selectedEvents =[];

  DateTime firstDay = DateTime.utc(2010, 10, 16);
  DateTime lastDay = DateTime.utc(2030, 3, 14);

  Calendar():events=LinkedHashMap<DateTime,List<Event>>(
    equals: isSameDay,
    hashCode: (DateTime key)=>key.day * 1000000 + key.month * 10000 + key.year
  );
  Future<void> init() async{
    await updateEvents();
  }

  Future<void> updateEvents() async {
    List<Application> applications = await firestore.getApplicationsFromUser();
    events.clear();
    for (Application app in applications) {
      DateTime eventDate = DateTime(app.timestamp.year, app.timestamp.month, app.timestamp.day);
      Event newEvent = Event(app.jobTitle, app.applicationStage, app.companyName, app.location, app.payRate);

      if (events.containsKey(eventDate)) {
        events[eventDate]?.add(newEvent);
      } else {
        events[eventDate] = [newEvent];
      }
    }
  }
}

class Event {
  final String title;
  final String application;
  final String company;
  final String location;
  final double payRate;

  const Event(this.title, this.application, this.company, this.location, this.payRate);

  @override
  String toString() => title;
}

