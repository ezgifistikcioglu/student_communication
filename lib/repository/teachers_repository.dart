class TeachersRepository {
  final List<Teacher> teachers = [
    Teacher(name: 'Randolph', surname: 'Gibson', age: 30, gender: 'Male'),
    Teacher(name: 'Sharon', surname: 'Jones', age: 30, gender: 'Female'),
    Teacher(name: 'Matthew', surname: 'Morales', age: 30, gender: 'Male'),
    Teacher(name: 'Minnie', surname: 'Battle', age: 30, gender: 'Female'),
  ];
}

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
