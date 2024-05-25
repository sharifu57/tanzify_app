import 'package:flutter/material.dart';

class PlainInputForm extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  // final String prefixAmount;
  final String hintText;
  final onSaved;
  final String maxLines;
  final TextInputType keyBoardInputType;
  // final VoidCallback onButtonPressed;
  const PlainInputForm({
    super.key,
    required this.validator,
    required this.onSaved,
    required this.controller,
    // required this.prefixAmount,
    required this.hintText,
    required this.maxLines,
    required this.keyBoardInputType,
    // required this.onButtonPressed
  });

  @override
  State<PlainInputForm> createState() => _PlainInputFormState();
}

class _PlainInputFormState extends State<PlainInputForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: int.parse(widget.maxLines),
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
        keyboardType: widget.keyBoardInputType,
        onSaved: widget.onSaved,
        // The validator receives the text that the user has entered.
        validator: widget.validator);
  }
}
