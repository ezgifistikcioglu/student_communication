import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/product/models/student_model.dart';
import 'package:student_communication/product/models/teacher_model.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = "https://648888560e2469c038fdeffe.mockapi.io/";

  Future<Student> studentDownload() async {
    final response = await http.get(Uri.parse('$baseUrl/student/'));

    if (response.statusCode == 200) {
      return Student.fromMap(jsonDecode(response.body)[3]);
    } else {
      throw showException(response, "Student could not be downloaded.");
    }
  }

  Future<Teacher> teacherDownload() async {
    final response = await http.get(Uri.parse('$baseUrl/teacher/1'));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw showException(response, "Teacher could not be downloaded.");
    }
  }

  Future<void> teacherAdd(Teacher newTeacher) async {
    var teacherMap = newTeacher.toMap();

    await FirebaseFirestore.instance.collection('teachers').add(teacherMap);

    /*
    // with http using
      final response = await http.post(
        Uri.parse('$baseUrl/teacher'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(teacherMap),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw showException(response, "Teacher could not be added.");
      }
    */
  }

  showException(http.Response response, String name) =>
      Exception('The $name ${response.statusCode}');

  Future<List<Teacher>> getAllTeachers() async {
    // get teachers from firebase
    final querySnapshot =
        await FirebaseFirestore.instance.collection('teachers').get();
    return querySnapshot.docs.map((e) => Teacher.fromMap(e.data())).toList();

    /*
    // mockApi-http 
    final response = await http.get(Uri.parse('$baseUrl/teacher'));

    if (response.statusCode == 200) {
      final dynamicList = jsonDecode(response.body);
      return dynamicList.map<Teacher>((e) => Teacher.fromMap(e)).toList();
    } else {
      throw showException(response, "Teacher could not be brought.");
    }
    */
  }
}

final dataServiceProvider = Provider((ref) => DataService());
