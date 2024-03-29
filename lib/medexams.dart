import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
//import 'package:intl/intl.dart';

//String extractDate(DateTime date) {
//return DateFormat('yyyy-MM-dd').format(date);
//}

// Exam class
class Exam {
  final String title;
  DateTime date;
  String pdfPath;

  Exam(this.title, this.date, this.pdfPath);

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      json['title'] as String,
      DateTime.parse(json['date'] as String),
      json['pdfPath'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'date': date.toIso8601String(),
        'pdfPath': pdfPath,
      };
}

class MedicalExams extends StatefulWidget {
  const MedicalExams({Key? key}) : super(key: key);

  @override
  //_MedicalExams createState() => _MedicalExams();
  State<MedicalExams> createState() => _MedicalExams();
}

class _MedicalExams extends State<MedicalExams> {
  List<Exam> _exams = [];
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedDateText = 'Select date';
  String _filePath = '';

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  void _navigateToExamPage(Exam exam) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamPage(exam, deleteExam),
      ),
    );
  }

  void updateSelectedDateText() {
    _selectedDateText =
        'Selected date: ${_selectedDate.toString().substring(0, 10)}';
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
          "My Exams",
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: ListView.builder(
        itemCount: _exams.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_exams[index].title),
            subtitle: Text(_exams[index].date.toString()),
            onTap: () => _navigateToExamPage(_exams[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Add New Exam"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Exam type',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    minimumSize: const Size(20, 4),
                    textStyle: const TextStyle(fontSize: 28),
                  ),
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                        updateSelectedDateText();
                      });
                    }
                  },
                  child: Text(_selectedDateText),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _openFileExplorer();
                  },
                  child: const Text('Add PDF file'),
                ),
                const SizedBox(height: 20),
                Text(_filePath),
              ],
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text("Save"),
                onPressed: () {
                  if (_titleController.text.isEmpty) {
                  } else {
                    if (_exams.isNotEmpty) {
                      _addExam(_titleController.text,
                          _selectedDate ?? DateTime.now(), _filePath);
                    } else {
                      _addExam(_titleController.text,
                          _selectedDate ?? DateTime.now(), _filePath);
                    }
                  }
                  Navigator.pop(context);
                  _titleController.clear();
                  _selectedDate = DateTime.now();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: const Text("Add New Exam"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _loadExams() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? exams = _prefs.getStringList('exams');
    if (exams != null) {
      _exams = exams.map((exam) => Exam.fromJson(jsonDecode(exam))).toList();
      setState(() {});
    }
  }

  void _addExam(String title, DateTime date, String pdfPath) {
    if (title.isNotEmpty && pdfPath.isNotEmpty) {
      _exams.add(Exam(title, date, pdfPath));
      _prefs.setStringList(
          'exams', _exams.map((exam) => jsonEncode(exam.toJson())).toList());
      setState(() {});
    }
  }

  void deleteExam(Exam exam) {
    //showDialog(
    // context: context,
    //builder: (context) => AlertDialog(
    //title: Text("Delete Exam"),
    //content: Text("Are you sure you want to delete this exam?"),
    // actions: [
    // TextButton(
    //  child: Text("Cancel"),
    //  onPressed: () => Navigator.pop(context),
    // ),
    // TextButton(
    //  child: Text("Delete"),
    //  onPressed: () {
    //    _exams.remove(exam);
    //    _prefs.setStringList(
    //      'exams',
    //     _exams.map((exam) => jsonEncode(exam.toJson())).toList(),
    //  );
    // Navigator.pop(context);
    // setState(() {});
    //   },
    //  ),
    // ],
    // ),
    // );

    _exams.remove(exam);
    _prefs.setStringList(
        'exams', _exams.map((exam) => jsonEncode(exam.toJson())).toList());
    setState(() {});
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path as String;
      });
    }
  }
}

// Exam page widget
class ExamPage extends StatefulWidget {
  final Exam exam;
  final Function(Exam exam) onDelete;

  const ExamPage(this.exam, this.onDelete, {Key? key}) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPage();
}

class _ExamPage extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          widget.exam.title,
          style: TextStyle(
              fontSize: 28, color: Theme.of(context).primaryColorLight),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.onDelete(widget.exam);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: PDFView(
          filePath: widget.exam.pdfPath,
        ),
      ),
      //floatingActionButton: FloatingActionButton.extended(
      //onPressed: () {
      //onDelete(exam);
      //Navigator.pop(context);
      //_deleteExamPage(context);
      //},
      // label: Text("Delete"),
      // icon: Icon(Icons.delete),
      //),
    );
  }

  //void _deleteExamPage(BuildContext context) {
  //final _MedicalExams medicalExams =
  //context.findAncestorWidgetOfExactType<_MedicalExams>()!;
  //medicalExams.deleteExam(exam);
  //Navigator.pop(context);
  //}
}
