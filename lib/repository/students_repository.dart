import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/product/services/data_service.dart';

import '../product/models/student_model.dart';

class StudentsRepository extends ChangeNotifier {
  final DataService dataService;

  StudentsRepository(this.dataService);

  final List<Student> students = [
    Student(name: 'Jane', surname: 'Doe', age: 17, gender: 'Female'),
  ];

  final Set<Student> myLovedOnes = {};

  void like(Student student, bool doILove) {
    if (doILove) {
      myLovedOnes.add(student);
    } else {
      myLovedOnes.remove(student);
    }
    notifyListeners();
  }

  bool doILove(Student student) {
    return myLovedOnes.contains(student);
  }

  Future<void> download() async {
    Student studentData = await dataService.studentDownload();

    students.add(studentData);
    notifyListeners();
  }
}

final studentProvider = ChangeNotifierProvider(
    (ref) => StudentsRepository(ref.watch(dataServiceProvider)));
