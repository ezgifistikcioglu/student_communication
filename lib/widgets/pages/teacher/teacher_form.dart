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
        title: const Text(ApplicationConstants.addTeacherText),
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
                  labelText: ApplicationConstants.nameText,
                  validatorText: ApplicationConstants.valNameComment,
                  suffixIcon: Icons.texture_rounded,
                ),
                TextFormFieldWidget(
                  req: req,
                  context: context,
                  labelText: ApplicationConstants.surnameText,
                  validatorText: ApplicationConstants.valSurnameComment,
                  suffixIcon: Icons.text_format_rounded,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: ApplicationConstants.ageText,
                      suffixIcon: Icon(Icons.format_size_rounded)),
                  onSaved: (newValue) {
                    req['age'] = int.parse(newValue!);
                  },
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return ApplicationConstants.valAgeComment;
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
        dropdownItem(
            ApplicationConstants.genderFText,
            const Text(
              ApplicationConstants.genderFText,
            )),
        dropdownItem(
          ApplicationConstants.genderMText,
          const Text(ApplicationConstants.genderMText),
        )
      ],
      value: req[ApplicationConstants.genderText],
      onChanged: (value) {
        setState(() {
          req[ApplicationConstants.genderText] = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return ApplicationConstants.valGenderComment;
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
            debugPrint('***** $req');
          }
          _teacherSave();
        },
        child: const Text(ApplicationConstants.saveText));
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
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  void checkIsSavingStatus() {
    setState(() {
      isSaving = !isSaving;
    });
  }
}
