import 'package:flutter/material.dart';

import 'package:medme/diary.dart';
import 'package:medme/medexams.dart';
import 'package:medme/prescriptions.dart';

import 'package:medme/infopage.dart';
import 'package:medme/welcomepage.dart';
import 'package:table_calendar/table_calendar.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          const Expanded(
            child: SizedBox(
              height: 350,
              width: 100,
            ),
          ),
          Expanded(
            child: Row(children: <Widget>[
              VerticalDivider(
                thickness: 10,
                width: 10,
                color: Theme.of(context).canvasColor,

              ),
              Expanded(
                child: SizedBox(
                    width: 250,
                    height: 90,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        backgroundColor: Theme.of(context).primaryColorLight,
                        minimumSize: const Size(20, 4),
                        textStyle: const TextStyle(fontSize: 28),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Info()),
                        );
                      },
                      child: const Text('INFO'),
                    )),
              ),
              VerticalDivider(
                thickness: 10,
                width: 10,
                color: Theme.of(context).canvasColor,
              ),
              Expanded(
                  child: SizedBox(
                width: 250,
                height: 90,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyPrescriptions()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    minimumSize: const Size(20, 4),
                    textStyle: const TextStyle(fontSize: 26),
                  ),
                  child: const Text('PRESCRIPTIONS'),
                ),
              )),
              VerticalDivider(
                thickness: 10,
                width: 10,
                color: Theme.of(context).canvasColor,
              ),
            ]),
          ),
          // Divider(
          //   thickness: 10,
          //   height: 10,
          //   color: Theme.of(context).canvasColor,
          // ),
          Expanded(
              child: Row(children: <Widget>[
            VerticalDivider(
              thickness: 10,
              width: 10,
              color: Theme.of(context).canvasColor,
            ),
            Expanded(
              child: SizedBox(
                  width: 250,
                  height: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MedicalExams()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      backgroundColor: Theme.of(context).primaryColorLight,
                      minimumSize: const Size(20, 4),
                      textStyle: const TextStyle(fontSize: 28),
                    ),
                    child: const Text(
                      'MEDICAL EXAMS',
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            VerticalDivider(
              thickness: 10,
              width: 10,
              color: Theme.of(context).canvasColor,
            ),
            Expanded(
              child: SizedBox(
                width: 250,
                height: 90,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Diary()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    minimumSize: const Size(20, 4),
                    textStyle: const TextStyle(fontSize: 28),
                  ),
                  child: const Text('DIARY'),
                ),
              ),
            ),
            VerticalDivider(
              thickness: 10,
              width: 10,
              color: Theme.of(context).canvasColor,
            ),
          ]))
        ],
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
