import 'package:flutter/material.dart';
import 'infopage.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your app logo here
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 300,
            ),
             const SizedBox(height: 20),
            // Add your welcome message here
            const Text(
              'All information regarding your health in one place',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Add a button to create profile
            ElevatedButton(
              onPressed: () {
                // Navigate to info page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoPage()),
                );
              },
              child: Text('Create your profile'),
            ),
          ],
        ),
      ),
    );
  }
}
