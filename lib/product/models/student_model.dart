class Student {
  String? name;
  String? surname;
  int? age;
  String? gender;

  Student({
    this.name,
    this.surname,
    this.age,
    this.gender,
  });

  Student.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    age = json['age'];
    gender = json['gender'];
  }
}
