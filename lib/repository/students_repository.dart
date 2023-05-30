class StudentsRepository {
  final List<Student> students = [
    Student(name: 'Mark', surname: 'Doe', age: 18, gender: 'Male'),
    Student(name: 'Barbara', surname: 'Burns', age: 18, gender: 'Female'),
    Student(name: 'Michael', surname: 'Fole', age: 18, gender: 'Male'),
    Student(name: 'Alanna', surname: 'Mejia', age: 18, gender: 'Female'),
  ];

  final Set<Student> myLovedOnes = {};

  void like(Student student, bool doILove) {
    if (doILove) {
      myLovedOnes.add(student);
    } else {
      myLovedOnes.remove(student);
    }
  }

  bool doILove(Student student) {
    return myLovedOnes.contains(student);
  }
}

class Student {
  String name;
  String surname;
  int age;
  String gender;

  Student({
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
  });
}
