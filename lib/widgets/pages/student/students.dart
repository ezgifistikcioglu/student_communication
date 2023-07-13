import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/product/constants/app_constants.dart';
import 'package:student_communication/repository/students_repository.dart';
import 'package:student_communication/widgets/customs/custom_download_button.dart';

import '../../../product/models/student_model.dart';

class Students extends ConsumerWidget {
  const Students({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentRepository = ref.watch(studentProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(ApplicationConstants.studentsPageText)),
      body: Column(
        children: [
          textLengthContainer(studentLength(studentRepository, context)),
          Align(
            alignment: Alignment.centerRight,
            child:
                CustomDownloadButton(changeNotifierProvider: studentProvider),
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return StudentListTile(studentRepository.students[index]);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: studentRepository.students.length)),
        ],
      ),
    );
  }

  Widget studentLength(
      StudentsRepository studentRepository, BuildContext context) {
    return Padding(
        padding: ApplicationConstants.symmetricPadding,
        child: Hero(
          tag: 'student',
          child: Material(
            child: Container(
              padding: ApplicationConstants.leftRighPadding,
              color: Colors.purple.shade100,
              child: TextButton(
                onPressed: () => goToStudents(context),
                child: Text(
                    '${studentRepository.students.length} ${ApplicationConstants.studentsPageText}'),
              ),
            ),
          ),
        ));
  }
}

class StudentListTile extends ConsumerWidget {
  final Student student;
  const StudentListTile(
    this.student, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool doILove = ref.watch(studentProvider).doILove(student);
    return ListTile(
      title: AnimatedPadding(
        duration: const Duration(seconds: 1),
        padding:
            doILove ? const EdgeInsets.only(left: 60) : const EdgeInsets.only(),
        curve: Curves.bounceOut,
        child: Text('${student.name} ${student.surname}'),
      ),
      leading: Icon(student.gender == ApplicationConstants.genderFText
          ? Icons.person_2_outlined
          : Icons.person_3_outlined),
      trailing: IconButton(
        onPressed: () {
          ref.read(studentProvider).like(student, !doILove);
        },
        icon: AnimatedCrossFade(
          duration: const Duration(seconds: 2),
          firstChild: const Icon(Icons.favorite),
          secondChild: const Icon(Icons.favorite_border),
          crossFadeState:
              doILove ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
