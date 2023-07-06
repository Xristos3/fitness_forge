import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarScreen2 extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen2> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {};

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEvents();
    _fetchEventsForSelectedDay(_selectedDay);
  }

  Future<void> fetchEvents() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final eventsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('events');

      final querySnapshot = await eventsCollection.get();

      final Map<DateTime, List<String>> eventsData = {};
      querySnapshot.docs.forEach((doc) {
        final eventDate = (doc['date'] as Timestamp).toDate();
        final event = doc['event'] as String;

        eventsData[eventDate] = eventsData[eventDate] ?? [];
        eventsData[eventDate]!.add(event);
      });

      setState(() {
        _events = Map.from(eventsData);
      });
    } catch (e) {
      print('Failed to fetch events from Firestore: $e');
    }
  }

  Future<void> _fetchEventsForSelectedDay(DateTime selectedDay) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final eventsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('events');

      final querySnapshot = await eventsCollection
          .where('date', isEqualTo: selectedDay)
          .get();

      final List<String> eventsData = [];
      querySnapshot.docs.forEach((doc) {
        final event = doc['event'] as String;
        eventsData.add(event);
      });

      setState(() {
        _events[selectedDay] = eventsData;
      });
    } catch (e) {
      print('Failed to fetch events for selected day: $e');
    }
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _showAddEventDialog,
                child: Text('Add Event'),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _fetchEventsForSelectedDay(selectedDay);
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Selected Day Events:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _events[_selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                final event = _events[_selectedDay]![index];
                return ListTile(
                  title: Text(event),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      setState(() {
                        _events[_selectedDay]!.removeAt(index);
                      });

                      try {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        final eventsCollection = FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUser!.uid)
                            .collection('events');

                        final querySnapshot = await eventsCollection
                            .where('date', isEqualTo: _selectedDay)
                            .where('event', isEqualTo: event)
                            .limit(1)
                            .get();

                        if (querySnapshot.docs.isNotEmpty) {
                          final eventDoc = querySnapshot.docs.first;
                          await eventDoc.reference.delete();
                        }
                      } catch (e) {
                        print('Failed to delete event from Firestore: $e');
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Event'),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(labelText: 'Event'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final currentUser = FirebaseAuth.instance.currentUser;
              final event = _eventController.text;

              if (event.isNotEmpty) {
                _events[_selectedDay] ??= [];
                _events[_selectedDay]!.add(event);
                setState(() {
                  _eventController.clear();
                });

                try {
                  final eventsCollection = FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser!.uid)
                      .collection('events');

                  await eventsCollection.add({
                    'date': _selectedDay,
                    'event': event,
                  });

                  setState(() {});
                } catch (e) {
                  print('Failed to add event to Firestore: $e');
                }
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
