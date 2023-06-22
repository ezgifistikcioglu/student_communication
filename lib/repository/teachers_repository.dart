import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/product/services/data_service.dart';

import '../product/models/teacher_model.dart';

class TeachersRepository extends ChangeNotifier {
  final DataService dataService;

  List<Teacher> teachers = [
    Teacher(name: 'Minnie', surname: 'Battle', age: 30, gender: 'Female'),
  ];

  TeachersRepository(this.dataService);

  Future<void> download() async {
    Teacher teacherData = await dataService.teacherDownload();

    teachers.add(teacherData);
    notifyListeners();
  }

  Future<List<Teacher>> getAllUsers() async {
    teachers = await dataService.getAllTeachers();
    return teachers;
  }
}

final teachersProvider = ChangeNotifierProvider(
    (ref) => TeachersRepository(ref.watch(dataServerProvider)));

final teacherListProvider =
    FutureProvider((ref) => ref.watch(teachersProvider).getAllUsers());
