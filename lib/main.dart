import 'package:flutter/material.dart';

void main() {
  runApp(const MedMe());
}

class MedMe extends StatelessWidget {
  const MedMe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          navigationBarTheme: const NavigationBarThemeData(
            height: 70.0,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          )),
      home: const Profilescreen(),
    );
  }
}

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  _ProfilescreenState createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      destinations: <Widget>[
        NavigationDestination(
          icon: Image.asset(
            "../assets/images/farmacy.png",
            scale: 3.0,
          ),
          label: '',
        ),
        NavigationDestination(
          icon: Image.asset(
            "../assets/images/profile.png",
            scale: 3.0,
          ),
          label: '',
        ),
        NavigationDestination(
          icon: Image.asset(
            "../assets/images/hospital.png",
            scale: 3.0,
          ),
          label: '',
        ),
      ],
      height: 70.0,
    ));
  }
}
