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
  }

  @override
  Widget build(BuildContext context) {
    if (currentPageIndex == 1) {
      return ListView.separated(
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
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text('Hospital Page'),
        ),
      );
    }
  }
}
