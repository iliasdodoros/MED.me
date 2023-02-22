import 'package:flutter/material.dart';

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
                // handle button press
              },
              child: Text('INFO'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 4)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                // handle button press
              },
              child: Text('PRESCRIPTIONS'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 4)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                // handle button press
              },
              child: Text('MEDICAL EXAMS'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 4)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                // handle button press
              },
              child: Text('DIARY'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 8)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 28)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
