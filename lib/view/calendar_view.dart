import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:job_market_app/viewmodel/calendar_viewmodel.dart';
import 'component/drawer.dart';

class CalendarView extends StatelessWidget {
  String username;
  CalendarView({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CalendarViewModel>(context);
    return Scaffold(
    appBar: AppBar(
      title: const Text('Calendar'),
      automaticallyImplyLeading: true,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .primaryContainer,
    ),
    drawer: AppDrawer(
      key: Key('AppDrawer'), currentPage: 'CalendarView', user: username,
    ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: viewModel.firstDay,
            lastDay: viewModel.lastDay,
            focusedDay: viewModel.focusedDay,
            calendarFormat: viewModel.calendarFormat!,
            onFormatChanged: (format) {
              viewModel.calendarFormat = format;
            },
            rangeStartDay: viewModel.rangeStart,
            rangeEndDay: viewModel.rangeEnd,
            rangeSelectionMode: viewModel.rangeSelectionMode,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: BoxShape.rectangle,
              ),
              weekendTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(viewModel.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              viewModel.onDaySelected(selectedDay, focusedDay);
            },
            onRangeSelected: (rangeStart,rangeEnd,focusedDay)=>viewModel.onRangeSelected(rangeStart, rangeEnd, focusedDay),
            onPageChanged: (focusedDay) {
              viewModel.focusedDay = focusedDay;
            },
            eventLoader: viewModel.getEventsForDay,
          ),
          Consumer<CalendarViewModel>(
            builder: (context, viewModel, child) {
              var events = viewModel.selectedEvents;
              events.sort((a, b) => (viewModel.applicationStagePriority[a.application] ?? 0).compareTo(viewModel.applicationStagePriority[b.application] ?? 0));              return Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ${events[index].application}:',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              title: Text('${events[index].title} @ ${events[index].company}'),
                              subtitle: Text(
                                    '${events[index].location}\n'
                                    '\$${NumberFormat("#,##0").format(events[index].payRate)}',
                              ),
                            ),
                          ],
                        ),
                      )
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
