import 'package:flutter/material.dart';

class CheckBoxButtonFormInput extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool?) onChanged;
  final Function(bool?) onSaved;

  const CheckBoxButtonFormInput({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.onSaved,
  });

  @override
  State<CheckBoxButtonFormInput> createState() => _CheckBoxButtonFormInputState();
}

class _CheckBoxButtonFormInputState extends State<CheckBoxButtonFormInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          leading: Checkbox(
            value: widget.value,
            onChanged: (bool? newValue) {
              setState(() {
                widget.onChanged(newValue);
                widget.onSaved(newValue);
              });
            },
          ),
        ),
      ],
    );
  }
}
