import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/product/constants/app_constants.dart';

class TeacherForm extends ConsumerStatefulWidget {
  const TeacherForm({super.key});

  @override
  _TeacherFormState createState() => _TeacherFormState();
}

class _TeacherFormState extends ConsumerState<TeacherForm> {
  final Map<String, dynamic> req = {};
  final _formKey = GlobalKey<FormState>();

  final bool _isFormDirty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
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
              children: <Widget>[
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      suffixIcon: Icon(Icons.texture_rounded)),
                  onSaved: (newValue) {
                    req['name'] = newValue;
                  },
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return 'Name cannot be empty';
                    }
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'surname',
                      suffixIcon: Icon(Icons.text_format_rounded)),
                  onSaved: (newValue) {
                    req['surname'] = newValue;
                  },
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return 'Surname cannot be empty';
                    }
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
