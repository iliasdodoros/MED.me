import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medme/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _Diary();
}

class _Diary extends State<Diary> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  // load and save events data using SharedPreferences
  final String _eventsKey = 'events';
  late SharedPreferences _prefs;

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedEvents == null) {
      return CircularProgressIndicator(); // show a loading indicator while data is being loaded
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          "Diary",
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            //calendarController: _calendarController,
            firstDay: DateTime.utc(2013, 10, 16),
            lastDay: DateTime.utc(2033, 3, 14),
            focusedDay: _focusedDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            // Day Changed
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update _focusedDay here as well
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                shape: BoxShape.circle,
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          ..._getEventsfromDay(_selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteEvent(event),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
              decoration: InputDecoration(
                hintText: 'Enter title',
              ),
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[_selectedDay] != null) {
                      _addEvent(_eventController.text);
                      //Event(title: _eventController.text),
                      //);
                    } else {
                      _addEvent(_eventController.text);
                      //selectedEvents[_selectedDay] = [
                      //  Event(title: _eventController.text)
                      //];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }

  // method to load events data from SharedPreferences
  void _loadEvents() async {
    _prefs = await SharedPreferences.getInstance();
    final eventsString = _prefs.getString(_eventsKey);
    if (eventsString != null) {
      final eventsMap = json.decode(eventsString) as Map<String, dynamic>;
      selectedEvents = eventsMap.map(
        (key, value) {
          final date = DateTime.parse(key);
          final eventsList =
              (value as List).map((e) => Event.fromJson(e)).toList();
          return MapEntry(date, eventsList);
        },
      );
    } else {
      selectedEvents = {};
    }
    setState(() {}); // update the state to rebuild the UI with the loaded data
  }

  // method to save events data to SharedPreferences
  void _saveEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventsMap = selectedEvents.map(
      (key, value) =>
          MapEntry(key.toString(), value.map((e) => e.toJson()).toList()),
    );
    final eventsString = json.encode(eventsMap);
    await prefs.setString(_eventsKey, eventsString);
  }

  void _addEvent(String title) {
    if (title.isNotEmpty) {
      final event = Event(title: title);
      final events = selectedEvents[_selectedDay] ?? [];
      selectedEvents[_selectedDay] = [...events, event];
      _saveEvents(); // Call _saveEvents() every time events data is updated
      setState(() {});
    }
  }

  void _deleteEvent(Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Event"),
        content: Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () {
              //Navigator.pop(context);
              setState(() {
                selectedEvents[_selectedDay]?.remove(event);
              });
              _saveEvents();

              Navigator.pop(context);
              //setState(() {});
            },
          ),
        ],
      ),
    );
    //setState(() {
    //selectedEvents[_selectedDay]?.remove(event);
    //});
    //_saveEvents();
  }
}
