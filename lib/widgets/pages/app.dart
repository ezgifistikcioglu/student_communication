import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/product/constants/app_constants.dart';
import 'package:student_communication/repository/messages_repository.dart';
import 'package:student_communication/repository/students_repository.dart';
import 'package:student_communication/repository/teachers_repository.dart';
import 'package:student_communication/widgets/pages/message/messages.dart';
import 'package:student_communication/widgets/pages/student/students.dart';
import 'package:student_communication/widgets/pages/teacher/teachers.dart';

import '../customs/custom_drawer.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, this.title = ApplicationConstants.homePageText});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentProvider);
    final teachersRepository = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => goToMessages(context),
              child:
                  Text('${ref.watch(newMessagesNumberProvider)} new messages'),
            ),
            heroForUsersAnimation(
              'student',
              context,
              TextButton(
                onPressed: () => goToStudents(context),
                child:
                    Text('${studentsRepository.students.length} new students'),
              ),
            ),
            sizedBoxTen,
            heroForUsersAnimation(
              'teacher',
              context,
              TextButton(
                onPressed: () => goToTeachers(context),
                child:
                    Text('${teachersRepository.teachers.length} new teachers'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Hero heroForUsersAnimation(
      Object tag, BuildContext context, TextButton textButton) {
    return Hero(
      tag: tag,
      child: Material(
        child: Container(
            padding: ApplicationConstants.normalPadding,
            color: Colors.purple.shade100,
            child: textButton),
      ),
    );
  }
}
