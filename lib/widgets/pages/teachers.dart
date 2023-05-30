import 'package:flutter/material.dart';
import 'package:student_communication/repository/teachers_repository.dart';

import '../../core/constants/app_constants.dart';

class Teachers extends StatefulWidget {
  final TeachersRepository? teachersRepository;
  const Teachers(this.teachersRepository, {super.key});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teachers')),
      body: Column(
        children: [
          textLengthContainer(
            teacherLength(),
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (widget.teachersRepository != null) {
                      return TeacherListTile(
                          widget.teachersRepository!.teachers[index],
                          widget.teachersRepository!);
                    }
                    return const Placeholder();
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: widget.teachersRepository!.teachers.length)),
        ],
      ),
    );
  }

  Padding teacherLength() {
    return Padding(
      padding: ApplicationConstants.symmetricPadding,
      child: Text(widget.teachersRepository != null
          ? '${widget.teachersRepository!.teachers.length} teachers'
          : '- teachers'),
    );
  }
}

class TeacherListTile extends StatefulWidget {
  final Teacher teacher;
  final TeachersRepository teachersRepository;
  const TeacherListTile(
    this.teacher,
    this.teachersRepository, {
    super.key,
  });

  @override
  State<TeacherListTile> createState() => _TeacherListTileState();
}

class _TeacherListTileState extends State<TeacherListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.teacher.name} ${widget.teacher.surname}'),
      leading: Icon(widget.teacher.gender == "Female"
          ? Icons.person_2_outlined
          : Icons.person_3_outlined),
    );
  }
}
