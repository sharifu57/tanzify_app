import 'package:flutter/material.dart';

class CustomSelectForm extends StatelessWidget {
  final List<String> categories; // Accept List of String
  final String selectedCategory; // Accept String
  final Function(String?) onChanged;
  final Function(String?) onSaved;

  const CustomSelectForm({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
    required this.onSaved,
  });


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.grey, width: 1),
        //   borderRadius: BorderRadius.circular(12),
        // ),
        border: InputBorder.none,
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
        // filled: true,
        // fillColor: Colors.white,
      ),
      onChanged: onChanged,
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
    );
  }
}
