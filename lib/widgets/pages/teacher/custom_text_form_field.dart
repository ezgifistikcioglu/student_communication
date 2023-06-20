import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.req,
    required this.context,
    required this.labelText,
    required this.validatorText,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  final Map<String, dynamic> req;
  final BuildContext context;
  final String? labelText;
  final IconData? suffixIcon;
  final String? validatorText;
  final String? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.name,
      decoration:
          InputDecoration(labelText: labelText, suffixIcon: Icon(suffixIcon)),
      onSaved: (newValue) {
        req[labelText![0].toUpperCase()] = newValue;
      },
      validator: (value) {
        if (value?.isNotEmpty != true) {
          return validatorText;
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );
  }
}
