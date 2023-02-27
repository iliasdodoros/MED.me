import 'package:flutter/material.dart';

import 'package:medme/diary.dart';
import 'package:medme/medexams.dart';
import 'package:medme/prescriptions.dart';
import 'package:medme/infopage.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  File _imageFile = File('');

  Future<void> _handleCircleTap() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

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
          GestureDetector(
            onTap: _handleCircleTap,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 119, 234, 244),
              ),
              child: ClipOval(
                child: _imageFile != null
                    ? Image.file(
                        _imageFile,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
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
                          MaterialPageRoute(
                              builder: (context) => const InfoPage()),
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
