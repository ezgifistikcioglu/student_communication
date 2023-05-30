import 'package:flutter/material.dart';
import 'package:student_communication/repository/messages_repository.dart';
import 'package:student_communication/repository/students_repository.dart';
import 'package:student_communication/repository/teachers_repository.dart';
import 'package:student_communication/widgets/pages/messages.dart';
import 'package:student_communication/widgets/pages/students.dart';
import 'package:student_communication/widgets/pages/teachers.dart';

import '../custom_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MessagesRepository messagesRepository = MessagesRepository();
  StudentsRepository studentsRepository = StudentsRepository();
  TeachersRepository teachersRepository = TeachersRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => _goToMessages(context),
              child: Text('${messagesRepository.newMessageCount} new messages'),
            ),
            TextButton(
              onPressed: () => _goToStudents(context),
              child: Text('${studentsRepository.students.length} new students'),
            ),
            TextButton(
              onPressed: () => _goToTeachers(context),
              child: Text('${teachersRepository.teachers.length} new teachers'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToMessages(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Messages(messagesRepository)),
    );
  }

  _goToTeachers(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return Teachers(teachersRepository);
      },
    ));
  }

  _goToStudents(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return Students(studentsRepository);
      },
    ));
  }
}
