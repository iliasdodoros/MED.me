import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medme/event.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Info()),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 4)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
              child: Text('INFO'),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Prescriptions()),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 4)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
              child: Text('PRESCRIPTIONS'),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalExams()),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 4)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
              child: Text('MEDICAL EXAMS'),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Diary()),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 8)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
              child: Text('DIARY'),
            ),
          ),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Center(
        child: Text('This is the info page'),
      ),
    );
  }
}

class Prescriptions extends StatelessWidget {
  const Prescriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescriptions'),
      ),
      body: Center(
        child: Text('This is the Prescriptions page'),
      ),
    );
  }
}

class MedicalExams extends StatelessWidget {
  const MedicalExams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Exams'),
      ),
      body: Center(
        child: Text('This is the Medical Exams page'),
      ),
    );
  }
}

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _Diary();
}

class _Diary extends State<Diary> {
  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
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
        title: Text('Diary'),
        // centerTitle: true,
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
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 158, 144),
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
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
                      selectedEvents[_selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[_selectedDay] = [
                        Event(title: _eventController.text)
                      ];
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
}
