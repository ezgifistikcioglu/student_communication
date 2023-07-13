import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/pages/message/messages.dart';
import '../../widgets/pages/student/students.dart';
import '../../widgets/pages/teacher/teachers.dart';

class ApplicationConstants {
  static const String unknownText = 'Unknown';
  static const String errText = 'Error';
  static const String homeText = 'Home Page';
  static const String homePageText = 'Student Communication';
  static const String messagePageText = 'Messages';
  static const String studentsPageText = 'Students';
  static const String teachersPageText = 'Teachers';
  static const String sendText = 'SEND';
  static const String genderText = 'gender';
  static const String genderFText = 'Female';
  static const String genderMText = 'Male';
  static const String nameText = 'Name';
  static const String surnameText = 'Surname';
  static const String ageText = 'Age';
  static const String addTeacherText = 'Add Teacher';
  static const String saveText = 'Save';
  static const String valGenderComment = 'Please choose a gender';
  static const String valAgeComment = 'Age cannot be empty';
  static const String valSurnameComment = 'Surname cannot be empty';
  static const String valNameComment = 'Name cannot be empty';
  static const String logoutText = 'Logout';

  // Padding
  static const EdgeInsets normalPadding = EdgeInsets.all(8);
  static const EdgeInsets normal2xPadding = EdgeInsets.all(18);
  static const EdgeInsets symmetricPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static const EdgeInsets onlyPadding = EdgeInsets.only(top: 8, bottom: 8);
  static const EdgeInsets leftRighPadding = EdgeInsets.only(left: 4, right: 4);
}

// MediaQuery
double getMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.7;

double getMinWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.1;

double getMaxHeight(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.9;

double getMinHeight(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.08;

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

// SizedBox
SizedBox get sizedBoxFive => const SizedBox(height: 5);
SizedBox get sizedBoxTen => const SizedBox(height: 10);
SizedBox get sizedBoxFifteen => const SizedBox(height: 15);

// Color
Color get midPurple => const Color(0xFF985EA2);
Color get lightPurple => const Color(0xFFF7CFFE);
Color get normalPurple => const Color(0xFF9C27B0);
Color get normalWhite => const Color(0xFFFFFFFF);

//uid
String get uid => firebaseGetCurrentUser().uid;
User firebaseGetCurrentUser() => FirebaseAuth.instance.currentUser!;

BoxDecoration ellipticalBoxDecoration() {
  return BoxDecoration(
    color: normalPurple,
    borderRadius: const BorderRadius.all(
      Radius.elliptical(120, 45),
    ),
  );
}

Widget textLengthContainer(Widget? child) {
  return Container(
    margin: const EdgeInsets.all(0.05),
    decoration: ellipticalBoxDecoration(),
    padding: ApplicationConstants.onlyPadding,
    child: Center(
      child: child,
    ),
  );
}

Future<void> goToMessages(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Messages()),
  );
}

goToTeachers(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) {
      return const Teachers();
    },
  ));
}

goToStudents(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) {
      return const Students();
    },
  ));
}
