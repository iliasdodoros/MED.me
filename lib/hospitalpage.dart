import 'dart:convert';

import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPage();
}

class _HospitalPage extends State<HospitalPage> {
  int currentPageIndex = 1;
  List<String> clinics = [
    "Παθολογική",
    "Καρδιολογική",
    "Χειρουργική",
    "Αιματολογική",
    "Γαστρεντερολογική",
    "Δερματολογική",
    "Ενδοκρινολογική",
    "Νευρολογική",
    "Ογκολογική",
    "Οδοντιατρική",
    "Ορθοπαιδική"
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onTap(int index) {
    setState(() {
      currentPageIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Hospitals(
                currentPageIndex: currentPageIndex,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            "Clinics",
            style: TextStyle(
                fontSize: 28, color: Theme.of(context).primaryColorLight),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: clinics.length,
          itemBuilder: (BuildContext context, int counter) {
            return ListTile(
              tileColor: Theme.of(context).canvasColor,
              onTap: () => {_onTap(counter)},
              title: Text(clinics[counter]),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 0,
          ),
        ));
  }
}

const jsondata = '{ "hospitals": [ "Γενικό Κρατικό","Στρατιωτικό Νοσοκομείο"]}';
// const jsondata = '{ "hospitals": "Γενικό Κρατικό"}';

class Hospitals extends StatelessWidget {
  Hospitals({super.key, required this.currentPageIndex});

  final hospitallist = jsonDecode(jsondata);
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          "Hospitals",
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: Center(
        child: Text('''${hospitallist['hospitals'][1]}'''),
      ),
    );
  }
}
