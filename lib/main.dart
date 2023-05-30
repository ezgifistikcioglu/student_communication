import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_communication/widgets/pages/app.dart';
import 'package:student_communication/widgets/pages/messages.dart';
import 'package:student_communication/widgets/pages/students.dart';
import 'package:student_communication/widgets/pages/teachers.dart';

import 'core/constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Communication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: normalPurple,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(200, 20),
            ),
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "title"),
    );
  }
}
