import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/product/models/student_model.dart';
import 'package:student_communication/product/models/teacher_model.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = "https://648888560e2469c038fdeffe.mockapi.io/";

  Future<Teacher> teacherDownload() async {
    final response = await http.get(Uri.parse('$baseUrl/teacher/1'));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw showException(response, "teacher");
    }
  }

  Exception showException(http.Response response, String name) =>
      Exception("The $name isn't download ${response.statusCode}");

  Future<Student> studentDownload() async {
    final response = await http.get(Uri.parse('$baseUrl/student/'));

    if (response.statusCode == 200) {
      return Student.fromMap(jsonDecode(response.body));
    } else {
      throw showException(response, "student");
    }
  }
}

final dataServerProvider = Provider((ref) => DataService());
