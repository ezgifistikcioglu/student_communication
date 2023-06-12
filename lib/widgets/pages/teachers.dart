import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/repository/teachers_repository.dart';

import '../../core/constants/app_constants.dart';

class Teachers extends ConsumerWidget {
  const Teachers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherRepository = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Teachers')),
      body: Column(
        children: [
          textLengthContainer(
            teacherLength(teacherRepository),
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TeacherListTile(teacherRepository.teachers[index]);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: teacherRepository.teachers.length)),
        ],
      ),
    );
  }

  Padding teacherLength(TeachersRepository teachersRepository) {
    return Padding(
      padding: ApplicationConstants.symmetricPadding,
      child: Text('${teachersRepository.teachers.length} teachers'),
    );
  }
}

class TeacherListTile extends StatelessWidget {
  final Teacher teacher;
  const TeacherListTile(
    this.teacher, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${teacher.name} ${teacher.surname}'),
      leading: Icon(teacher.gender == "Female"
          ? Icons.person_2_outlined
          : Icons.person_3_outlined),
    );
  }
}
