import 'package:flutter/material.dart';

class SuccessSnackBar extends StatelessWidget {
  final String message;
  const SuccessSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        elevation: 2,
        content: Text(message));
  }
}
