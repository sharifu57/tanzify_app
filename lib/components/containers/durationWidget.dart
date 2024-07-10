import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';

class DurationWidget extends StatelessWidget {
  final String duration;
  const DurationWidget({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String message;
    Color color;
    int size = 11;

    switch (duration) {
      case "0":
        message = "Less than a month";
        color = Constants.accentColor;
        size = size;
        break;

      case "1":
        message = "1 to 3 months";
        color = Constants.accentColor;
        size = size;
        break;

      case "2":
        message = "6 month";
        color = Constants.accentColor;
        size = size;
        break;

      case "3":
        message = "More than 6 months";
        color = Constants.accentColor;
        size = size;
        break;

      default:
        message = "No Time";
        color = Constants.accentColor;
        size = size;
        break;
    }

    return Row(
      children: [
        // Icon(icon, size: 11, color: color),
        const SizedBox(width: 8),
        Text(
          message,
          style: TextStyle(color: color, fontSize: 11),
        ),
      ],
    );
  }
}
