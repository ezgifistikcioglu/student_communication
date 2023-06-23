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
          textLengthContainer(studentLength(studentRepository)),
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

  Padding studentLength(StudentsRepository studentRepository) {
    return Padding(
      padding: ApplicationConstants.symmetricPadding,
      child: Text(
          '${studentRepository.students.length} ${ApplicationConstants.studentsPageText}'),
    );
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
      title: Text('${student.name} ${student.surname}'),
      leading: Icon(student.gender == ApplicationConstants.genderFText
          ? Icons.person_2_outlined
          : Icons.person_3_outlined),
      trailing: IconButton(
        onPressed: () {
          ref.read(studentProvider).like(student, !doILove);
        },
        icon: Icon(doILove ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}