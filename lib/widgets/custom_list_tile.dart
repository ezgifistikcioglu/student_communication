import 'package:flutter/material.dart';

class NewListTile extends StatefulWidget {
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final Text? textTitle;
  final VoidCallback? onTap;

  const NewListTile(
      {super.key,
      this.leadingIcon,
      this.trailingIcon,
      this.textTitle,
      this.onTap});

  @override
  State<NewListTile> createState() => _NewListTileState();
}

class _NewListTileState extends State<NewListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading:
            widget.leadingIcon ?? const Icon(Icons.card_membership_outlined),
        title: widget.textTitle ?? const Text(''),
        trailing: widget.trailingIcon ?? const Icon(Icons.arrow_right),
        onTap: widget.onTap);
  }
}
