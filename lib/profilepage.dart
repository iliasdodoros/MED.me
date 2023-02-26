import 'package:flutter/material.dart';
import 'package:medme/diary.dart';
import 'package:medme/medexams.dart';
import 'package:medme/prescriptions.dart';

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
                  MaterialPageRoute(builder: (context) => MyPrescriptions()),
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
