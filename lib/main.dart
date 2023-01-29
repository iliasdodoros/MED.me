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
          // hoverColor: const Color.fromARGB(0, 255, 255, 255),
          navigationBarTheme: const NavigationBarThemeData(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 60,
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
  void _onTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentPageIndex,
          children: const [
            FarmacyPage(),
            ProfilePage(),
            HospitalPage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: _onTapped,
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
        ));
  }
}

class FarmacyPage extends StatelessWidget {
  const FarmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Farmacy Page'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}

class HospitalPage extends StatelessWidget {
  const HospitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hospital Page'),
      ),
    );
  }
}
