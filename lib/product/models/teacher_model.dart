class Teacher {
  String? name;
  String? surname;
  int? age;
  String? gender;

  Teacher({
    this.name,
    this.surname,
    this.age,
    this.gender,
  });

  Teacher.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'surname': surname, 'age': age, 'gender': gender};
  }
}
