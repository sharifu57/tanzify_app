import 'package:flutter/material.dart';

class SimpleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const SimpleIcon(
      {super.key,
      required this.icon,
      this.color = Colors.black,
      this.size = 22});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
