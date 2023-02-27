// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'profilepage.dart';
import 'hospitalpage.dart';
import 'farmacypage.dart';
import 'welcomepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

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
          canvasColor: Colors.white,
          // hoverColor: const Color.fromARGB(0, 255, 255, 255),
          navigationBarTheme: const NavigationBarThemeData(
            // indicatorColor: Color.fromARGB(255, 255, 148, 148),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 60,
          )),
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Mainscreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomePage()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
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
