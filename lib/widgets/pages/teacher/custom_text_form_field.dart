import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.labelText,
    this.suffixIcon,
    required this.validator,
    required this.onSaved,
  }) : super(key: key);

  final String? labelText;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.name,
      decoration:
          InputDecoration(labelText: labelText, suffixIcon: Icon(suffixIcon)),
      onSaved: onSaved,
      validator: validator,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );
  }
}
