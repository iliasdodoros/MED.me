import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController sexController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController bloodTypeController;

  String name = '';
  String age = '';
  String sex = '';
  String height = '';
  String weight = '';
  String bloodType = '';

  @override
  void initState() {
    super.initState();
    // Load saved user info
    _loadUserInfo();
  }

  @override
  void dispose() {
    // Dispose of the text editing controllers
    nameController.dispose();
    ageController.dispose();
    sexController.dispose();
    heightController.dispose();
    weightController.dispose();
    bloodTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the text editing controllers
    nameController = TextEditingController(text: name);
    ageController = TextEditingController(text: age);
    sexController = TextEditingController(text: sex);
    heightController = TextEditingController(text: height);
    weightController = TextEditingController(text: weight);
    bloodTypeController = TextEditingController(text: bloodType);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          _buildTextBanner('Name', nameController),
          _buildTextBanner('Age', ageController),
          _buildTextBanner('Sex', sexController),
          _buildTextBanner('Height', heightController),
          _buildTextBanner('Weight', weightController),
          _buildTextBanner('Blood Type', bloodTypeController),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _saveUserInfo();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mainscreen()),
                );
              },
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextBanner(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          const SizedBox(height: 5),
          TextFormField(
            decoration:const  InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:  EdgeInsets.all(10),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }

  Future<void> _saveUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('sex', sexController.text);
    await prefs.setString('height', heightController.text);
    await prefs.setString('weight', weightController.text);
    await prefs.setString('bloodType', bloodTypeController.text);
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name= prefs.getString('name') ?? '';
     age = prefs.getString('age') ?? '';
      sex = prefs.getString('sex') ?? '';
      height = prefs.getString('height') ?? '';
      weight = prefs.getString('weight') ?? '';
      bloodType = prefs.getString('bloodType') ?? '';
    });
  } 
  }


