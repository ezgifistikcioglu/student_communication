import 'package:flutter/material.dart';
import 'package:student_communication/core/constants/app_constants.dart';
import 'package:student_communication/repository/students_repository.dart';

class Students extends StatefulWidget {
  final StudentsRepository? studentsRepository;
  const Students(this.studentsRepository, {super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: Column(
        children: [
          textLengthContainer(studentLength()),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (widget.studentsRepository != null) {
                      return StudentListTile(
                          widget.studentsRepository!.students[index],
                          widget.studentsRepository!);
                    }
                    return const Placeholder();
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: widget.studentsRepository!.students.length)),
        ],
      ),
    );
  }

  Padding studentLength() {
    return Padding(
      padding: ApplicationConstants.symmetricPadding,
      child: Text(widget.studentsRepository != null
          ? '${widget.studentsRepository!.students.length} students'
          : '- students'),
    );
  }
}

class StudentListTile extends StatefulWidget {
  final Student student;
  final StudentsRepository studentsRepository;
  const StudentListTile(
    this.student,
    this.studentsRepository, {
    super.key,
  });

  @override
  State<StudentListTile> createState() => _StudentListTileState();
}

class _StudentListTileState extends State<StudentListTile> {
  @override
  Widget build(BuildContext context) {
    bool doILove = widget.studentsRepository.doILove(widget.student);
    return ListTile(
      title: Text('${widget.student.name} ${widget.student.surname}'),
      leading: Icon(widget.student.gender == "Female"
          ? Icons.person_2_outlined
          : Icons.person_3_outlined),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            widget.studentsRepository.like(widget.student, !doILove);
          });
        },
        icon: Icon(doILove ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}
