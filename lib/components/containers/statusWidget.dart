import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart'; // Adjust the import based on your project structure

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String message;
    Color color;
    int size = 11;

    switch (status) {
      case "0":
        icon = Icons.verified_user_outlined;
        message = "New";
        color = Constants.successColor;
        size = size;
      case "1":
        icon = Icons.verified_user_outlined;
        message = "Received";
        color = Constants.successColor;
        size = size;
        break;
      case "2":
        icon = Icons.cancel_outlined;
        message = "Cancelled";
        color = Constants.errorColor;
        size = size;
        break;
      // Add more cases as needed
      default:
        icon = Icons.help_outline;
        message = "Unknown";
        color = Colors.grey;
        size = size;
        break;
    }

    return Row(
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 8),
        Text(
          message,
          style: TextStyle(color: color, fontSize: 11),
        ),
      ],
    );
  }
}
