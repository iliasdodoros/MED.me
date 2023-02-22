import 'package:flutter/material.dart';
import 'profilepage.dart';
import 'hospitalpage.dart';
import 'farmacypage.dart';

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
          // hoverColor: const Color.fromARGB(0, 255, 255, 255),
          navigationBarTheme: const NavigationBarThemeData(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 60,
          )),
      home: const Mainscreen(),
    );
  }
}

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  State<Mainscreen> createState() => _Mainscreen();
}

class _Mainscreen extends State<Mainscreen> {
  int currentPageIndex = 1;
  final _pages = [
    const FarmacyPage(),
    const ProfilePage(),
    const HospitalPage()
  ];

  void _onTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: _onTapped,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: SizedBox(
                  width: 35,
                  height: 35,
                  child:
                      Image(image: AssetImage('./assets/images/farmacy.png'))),
              label: '',
            ),
            NavigationDestination(
              icon: SizedBox(
                  width: 35,
                  height: 35,
                  child:
                      Image(image: AssetImage('./assets/images/profile.png'))),
              label: '',
            ),
            NavigationDestination(
              icon: SizedBox(
                  width: 35,
                  height: 35,
                  child:
                      Image(image: AssetImage('./assets/images/hospital.png'))),
              label: '',
            ),
          ],
        ));
  }
}
