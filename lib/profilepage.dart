import 'package:flutter/material.dart';
import 'package:medme/diary.dart';
import 'package:medme/medexams.dart';

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
                          builder: (context) => const Prescriptions()),
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

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          "Info",
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: const Center(
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
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          "Prescriptions",
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: const Center(
        child: Text('This is the Prescriptions page'),
      ),
    );
  }
}
