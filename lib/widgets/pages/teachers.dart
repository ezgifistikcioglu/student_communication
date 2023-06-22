import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/repository/teachers_repository.dart';
import 'package:student_communication/widgets/custom_download_button.dart';

import '../../product/constants/app_constants.dart';
import '../../product/models/teacher_model.dart';
import 'teacher/teacher_form.dart';

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
          Align(
            alignment: Alignment.centerRight,
            child:
                CustomDownloadButton(changeNotifierProvider: teachersProvider),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.watch(teacherListProvider);
              },
              child: ref.watch(teacherListProvider).when(
                    data: (data) => ListView.separated(
                        itemBuilder: (context, index) {
                          return TeacherListTile(data[index]);
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: data.length),
                    error: (error, stackTrace) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Text('ERR'),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: normalPurple,
        onPressed: () async {
          final isCreatedNewTeacher =
              await Navigator.of(context).push<bool>(MaterialPageRoute(
            builder: (context) {
              return const TeacherForm();
            },
          ));
          if (isCreatedNewTeacher == true) {
            print('**** Teacher update');
          }
        },
        child: Icon(Icons.add, color: lightPurple),
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
