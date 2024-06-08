import 'package:flutter/material.dart';

class RadioButtonFormInput extends StatefulWidget {
  // final String selectedItem;
  final Function(String?) onSelectedItemChanged;
  final String title;
  final String value;
  final String groupValue;
  final Function(String?) onSaved;
  const RadioButtonFormInput(
      {super.key,
      required this.onSelectedItemChanged,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.onSaved});

  @override
  State<RadioButtonFormInput> createState() => _RadioButtonFormInputState();
}

class _RadioButtonFormInputState extends State<RadioButtonFormInput> {
  String? selectedItem;
  void handleSelectedItemChange(String value) {
    setState(() {
      selectedItem = value;
    });

    widget.onSelectedItemChanged(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          leading: Radio<String>(
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: (String? newValue) {
              widget.onSelectedItemChanged(newValue);
            },
          ),
        ),
      ],
    );
  }
}
