import 'package:flutter/material.dart';

class PlainInputForm extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  // final String prefixAmount;
  final String hintText;
  final onSaved;
  const PlainInputForm(
      {super.key,
      required this.validator,
      required this.onSaved,
      required this.controller,
      // required this.prefixAmount,
      required this.hintText});

  @override
  State<PlainInputForm> createState() => _PlainInputFormState();
}

class _PlainInputFormState extends State<PlainInputForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 12),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          // prefixText: widget.prefixAmount,
        ),
        // The validator receives the text that the user has entered.
        validator: widget.validator);
  }
}
