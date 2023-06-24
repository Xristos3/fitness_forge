import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Event {
  final String title;

  Event(this.title);
}

class EventProvider extends ChangeNotifier {
  Map<DateTime, List<Event>> events = {};

  void addEvent(DateTime date, Event event) {
    events[date] ??= [];
    events[date]!.add(event);
    notifyListeners();
  }

  void deleteEvent(DateTime date, Event event) {
    events[date]?.remove(event);
    notifyListeners();
  }
}

class EventCalendarPage extends StatefulWidget {
  @override
  _EventCalendarPageState createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventProvider>(context);
    var events = eventProvider.events;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime(2021),
            lastDay: DateTime(2022),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              return events[day] ?? [];
            },
          ),
          SizedBox(height: 16),
          Text('Selected Day: ${_selectedDay != null ? DateFormat('yyyy-MM-dd').format(_selectedDay!) : 'None'}'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              var event = Event('New Event');
              eventProvider.addEvent(_selectedDay!, event);
            },
            child: Text('Add Event'),
          ),
          SizedBox(height: 16),
          if (_selectedDay != null && events[_selectedDay!] != null)
            Column(
              children: events[_selectedDay!]!
                  .map((event) => ListTile(
                title: Text(event.title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    eventProvider.deleteEvent(_selectedDay!, event);
                  },
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}