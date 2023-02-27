import 'package:flutter/material.dart';
import 'package:medme/infopage.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => const InfoPage()),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(20, 4)),
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 28)),
              ),
              child: const Text('INFO'),
            ),
          ),
         const SizedBox(height: 16.0),
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

// class Info extends StatelessWidget {
//   const Info({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Info'),
//       ),
//       body: Center(
//         child: Text('This is the info page'),
//       ),
//     );
//   }
// }

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
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary'),
      ),
      body: TableCalendar(
        //calendarController: _calendarController,
        firstDay: DateTime.utc(2013, 10, 16),
        lastDay: DateTime.utc(2033, 3, 14),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update _focusedDay here as well
            });
          }
        },
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
    );
  }
}
