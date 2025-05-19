import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/src/shared/utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/calendar.dart';

class CalendarViewModel extends ChangeNotifier {
  final Calendar _model = Calendar();

  DateTime get focusedDay =>
      _model.focusedDay ??
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime get selectedDay =>
      _model.selectedDay ??
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  CalendarFormat? get calendarFormat => _model.calendarFormat;

  CalendarViewModel() {
    init();
    notifyListeners();
  }

  get firstDay => _model.firstDay;
  get lastDay => _model.lastDay;

  DateTime? get rangeStart => _model.rangeStart;
  DateTime? get rangeEnd => _model.rangeEnd;

  RangeSelectionMode get rangeSelectionMode => _model.rangeSelectionMode;

  List<Event> get selectedEvents => _model.selectedEvents;

  set selectedEvents(List<Event> newValue) {
    _model.selectedEvents = newValue;
    notifyListeners();
  }

  set rangeSelectionMode(RangeSelectionMode newValue) {
    _model.rangeSelectionMode = newValue;
    notifyListeners();
  }

  set rangeEnd(DateTime? newValue) {
    _model.rangeEnd = newValue;
    notifyListeners();
  }

  set rangeStart(DateTime? newValue) {
    _model.rangeStart = newValue;
    notifyListeners();
  }

  Future<void> init() async {
    await _model.init();
    notifyListeners();
  }

  set focusedDay(newValue) {
    _model.focusedDay = newValue;
    notifyListeners();
  }

  set calendarFormat(newValue) {
    _model.calendarFormat = newValue;
    notifyListeners();
  }

  set selectedDay(newValue) {
    _model.selectedDay = newValue;
    notifyListeners();
  }

  List<Event> getEventsForDay(DateTime day) {
    return _model.events[day] ?? [];
  }

  List<DateTime> _daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  List<Event> getEventsForRange(DateTime start, DateTime end) {
    final days = _daysInRange(start, end);

    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
      rangeStart = null; 
      rangeEnd = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;
    }
    
    this.selectedEvents = getEventsForDay(selectedDay);
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    selectedDay = null;
    this.focusedDay = focusedDay;
    rangeStart = start;
    rangeEnd = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;
    if (start != null && end != null) {
      log('SELECTING RANGE FROM $start to $end');
      log('${getEventsForRange(start, end)}');
      selectedEvents = getEventsForRange(start, end);
    } else if (start != null) {
      selectedEvents = getEventsForDay(start);
    } else if (end != null) {
      selectedEvents = getEventsForDay(end);
    }
  }

  Future<void> updateEvents() async {
    await _model.updateEvents();
  }
  Map<String, int> applicationStagePriority = {
    'Apply Soon': 1,
    'Applied': 2,
    'Interviewing': 3,
    'Received Offer': 4,
  };

}
