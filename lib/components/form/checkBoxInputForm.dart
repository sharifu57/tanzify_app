import 'package:flutter/material.dart';

class CustomCheckFormInput extends StatefulWidget {
  // final String selectedItem;
  final Function(String?) onSelectedItemChanged;
  final String title;
  final String value;
  final String groupValue;
  final Function(String?) onSaved;
  const CustomCheckFormInput(
      {super.key,
      required this.onSelectedItemChanged,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.onSaved});

  @override
  State<CustomCheckFormInput> createState() => _CustomCheckFormInputState();
}

class _CustomCheckFormInputState extends State<CustomCheckFormInput> {
  String? selectedItem;
  void handleSelectedItemChange(String value) {
    setState(() {
      selectedItem = value;
    });
    // if (widget.onSelectedItemChanged != null) {
    //   widget.onSelectedItemChanged(selectedItem);
    // }
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
