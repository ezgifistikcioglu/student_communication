// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:student_communication/product/constants/app_constants.dart';
import 'package:student_communication/product/models/teacher_model.dart';
import 'package:student_communication/product/services/data_service.dart';

import 'custom_text_form_field.dart';

class TeacherForm extends ConsumerStatefulWidget {
  const TeacherForm({super.key});

  @override
  _TeacherFormState createState() => _TeacherFormState();
}

class _TeacherFormState extends ConsumerState<TeacherForm> {
  final Map<String, dynamic> req = {};
  final _formKey = GlobalKey<FormState>();

  final bool _isFormDirty = false;

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Teacher"),
      ),
      body: SafeArea(
        child: Padding(
          padding: ApplicationConstants.normalPadding,
          child: Form(
            key: _formKey,
            autovalidateMode: _isFormDirty
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormFieldWidget(
                  req: req,
                  context: context,
                  labelText: 'Name',
                  validatorText: 'Name cannot be empty',
                  suffixIcon: Icons.texture_rounded,
                ),
                TextFormFieldWidget(
                  req: req,
                  context: context,
                  labelText: 'Surname',
                  validatorText: 'Surname cannot be empty',
                  suffixIcon: Icons.text_format_rounded,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Age',
                      suffixIcon: Icon(Icons.format_size_rounded)),
                  onSaved: (newValue) {
                    req['age'] = int.parse(newValue!);
                  },
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return 'Age cannot be empty';
                    }
                    if (int.tryParse(value!) == null) {
                      return 'Enter your age in numbers';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                genderDropdown(),
                isSaving
                    ? const Center(child: CircularProgressIndicator())
                    : saveButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<Object> genderDropdown() {
    return DropdownButtonFormField(
      items: [
        dropdownItem('Female', const Text('Female')),
        dropdownItem(
          'Male',
          const Text('Male'),
        )
      ],
      value: req['gender'],
      onChanged: (value) {
        setState(() {
          req['gender'] = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please choose a gender';
        }
        return null;
      },
    );
  }

  DropdownMenuItem<String> dropdownItem(String value, Widget child) {
    return DropdownMenuItem(
      value: value,
      child: child,
    );
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
        onPressed: () {
          final formState = _formKey.currentState;
          if (formState == null) return;
          if (formState.validate() == true) {
            formState.save();
            print('***** $req');
          }
          _teacherSave();
        },
        child: const Text('Save'));
  }

  Future<void> _teacherSave() async {
    bool isFinished = false;
    while (!isFinished) {
      try {
        checkIsSavingStatus();
        await _onButtonTapped();
        isFinished = true;
      } catch (e) {
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
        await snackBar.closed;
      } finally {
        checkIsSavingStatus();
      }
    }
  }

  int i = 0;
  Future<void> _onButtonTapped() async {
    // Fake test
    // i++;
    // if (i < 3) {
    //   throw 'Registration failed';
    // }
    final newTeacher = Teacher.fromMap(req);
    await ref.read(dataServerProvider).teacherAdd(newTeacher);

    Navigator.of(context).pop(true);
  }

  void checkIsSavingStatus() {
    setState(() {
      isSaving = !isSaving;
    });
  }
}
