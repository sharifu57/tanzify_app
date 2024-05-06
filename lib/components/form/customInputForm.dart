import 'package:flutter/material.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/pages/constants.dart';

class CustomInputForm extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final onSaved;
  final TextInputType keyBoardInputType;
  final bool obscureText;

  const CustomInputForm(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.hintStyle,
      required this.controller,
      required this.validator,
      required this.onSaved,
      required this.keyBoardInputType,
      this.obscureText = false});

  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyBoardInputType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        // fillColor: Constants.fillColor,
        // filled: true,

        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: _togglePasswordVisibility,
              )
            : null,
        border: InputBorder.none,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: const BorderSide(color: Colors.grey),
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
