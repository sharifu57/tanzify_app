import 'package:flutter/material.dart';

class FailedSnackBar extends StatelessWidget {
  final String message;
  const FailedSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        elevation: 2,
        content: Text(message));
  }
}
