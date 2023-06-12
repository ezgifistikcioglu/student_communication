import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeachersRepository extends ChangeNotifier {
  final List<Teacher> teachers = [
    Teacher(name: 'Randolph', surname: 'Gibson', age: 30, gender: 'Male'),
    Teacher(name: 'Sharon', surname: 'Jones', age: 30, gender: 'Female'),
    Teacher(name: 'Matthew', surname: 'Morales', age: 30, gender: 'Male'),
    Teacher(name: 'Minnie', surname: 'Battle', age: 30, gender: 'Female'),
  ];
}

final teachersProvider = ChangeNotifierProvider((ref) => TeachersRepository());

class Teacher {
  String name;
  String surname;
  int age;
  String gender;

  Teacher({
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
  });
}
