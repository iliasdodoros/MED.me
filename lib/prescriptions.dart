import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Prescription {
  final String title;
  String description;
  int frequency;

  Prescription(this.title, this.description, this.frequency);

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      json['title'] as String,
      json['description'] as String,
      json['frequency'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'frequency': frequency,
        'description': description,
      };
}

class MyPrescriptions extends StatefulWidget {
  const MyPrescriptions({Key? key}) : super(key: key);

  @override
  //_MedicalExams createState() => _MedicalExams();
  State<MyPrescriptions> createState() => _MyPrescriptions();
}

class _MyPrescriptions extends State<MyPrescriptions> {
  List<Prescription> _prescriptions = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedFrequency = 12;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPrescriptions();
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
          "Prescriptions",
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: ListView.builder(
        itemCount: _prescriptions.length,
        itemBuilder: (context, index) {
          final pres = _prescriptions[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(pres.title),
                    content: Text(pres.description),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                      TextButton(
                        onPressed: () => _deletePrescription(pres),
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              title: Text(pres.title),
              subtitle: Text('Every ${pres.frequency} hours.'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add New Prescription"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                  ),
                ),
                DropdownButton<int>(
                  value: _selectedFrequency,
                  hint: Text("Select Frequency"),
                  items: [
                    DropdownMenuItem(
                      child: Text("1 time per day"),
                      value: 24,
                    ),
                    DropdownMenuItem(
                      child: Text("2 times per day"),
                      value: 12,
                    ),
                    DropdownMenuItem(
                      child: Text("3 times per day"),
                      value: 8,
                    ),
                    DropdownMenuItem(
                      child: Text("4 time per day"),
                      value: 6,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFrequency = value!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Save"),
                onPressed: () {
                  if (_titleController.text.isEmpty) {
                  } else {
                    if (_prescriptions != null) {
                      _addPrescription(_titleController.text,
                          _descriptionController.text, _selectedFrequency);
                    } else {
                      _addPrescription(_titleController.text,
                          _descriptionController.text, _selectedFrequency);
                    }
                  }
                  Navigator.pop(context);
                  _titleController.clear();
                  _descriptionController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add New Prescription"),
        icon: Icon(Icons.add),
      ),
    );
  }

  void _loadPrescriptions() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? pres = _prefs.getStringList('prescriptions');
    if (pres != null) {
      _prescriptions = pres
          .map(
              (prescription) => Prescription.fromJson(jsonDecode(prescription)))
          .toList();
      setState(() {});
    }
  }

  void _addPrescription(String title, String description, int frequency) {
    if (title.isNotEmpty && frequency != null) {
      _prescriptions.add(Prescription(title, description, frequency));
      _prefs.setStringList(
          'prescriptions',
          _prescriptions
              .map((prescription) => jsonEncode(prescription.toJson()))
              .toList());
      setState(() {});
    }
  }

  //void _deletePrescription(Prescription prescription) {
  //_prescriptions.remove(prescription);
  //_prefs.setStringList(
  //  'prescriptions',
  //_prescriptions
  //  .map((Prescription) => jsonEncode(prescription.toJson()))
  //.toList());
  //setState(() {});
  //}

  void _deletePrescription(Prescription prescription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Prescription"),
        content: Text("Are you sure you want to delete this prescription?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () {
              _prescriptions.remove(prescription);
              _prefs.setStringList(
                'prescriptions',
                _prescriptions
                    .map((prescription) => jsonEncode(prescription.toJson()))
                    .toList(),
              );
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
