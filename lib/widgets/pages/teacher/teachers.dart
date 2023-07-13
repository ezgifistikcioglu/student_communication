import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/repository/teachers_repository.dart';
import 'package:student_communication/widgets/customs/custom_download_button.dart';

import '../../../product/constants/app_constants.dart';
import '../../../product/models/teacher_model.dart';
import 'teacher_form.dart';

class Teachers extends ConsumerWidget {
  const Teachers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherRepository = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(ApplicationConstants.teachersPageText)),
      body: Column(
        children: [
          textLengthContainer(
            teacherLength(teacherRepository, context),
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
                        child: Text(ApplicationConstants.errText),
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
            debugPrint('**** Teacher update');
          }
        },
        child: Icon(Icons.add, color: lightPurple),
      ),
    );
  }

  Widget teacherLength(
      TeachersRepository teachersRepository, BuildContext context) {
    return Padding(
      padding: ApplicationConstants.symmetricPadding,
      child: Hero(
        tag: 'teacher',
        child: Material(
          child: Container(
            padding: ApplicationConstants.leftRighPadding,
            color: Colors.purple.shade100,
            child: TextButton(
              onPressed: () => goToTeachers(context),
              child: Text(
                  '${teachersRepository.teachers.length} ${ApplicationConstants.teachersPageText}'),
            ),
          ),
        ),
      ),
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
      leading: Icon(teacher.gender == ApplicationConstants.genderFText
          ? Icons.person_2_outlined
          : Icons.person_3_outlined),
    );
  }
}
