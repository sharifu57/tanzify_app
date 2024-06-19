import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  // final String title;
  final String message;
  final VoidCallback? onOkPressed;
  final VoidCallback? onCancelPressed;
  // final IconData icon;
  final int type;

  const CustomDialog(
      {super.key,
      required this.message,
      // required this.title,
      required this.onOkPressed,
      required this.onCancelPressed,
      // required this.icon,
      required this.type});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late IconData icon;
  late String title;

  @override
  void initState() {
    // TODO: implement initState

    switch (widget.type) {
      case 1:
        title = "Warning";
        icon = Icons.warning;
        break;

      case 2:
        title = "Success";
        icon = Icons.check_circle;
        break;

      case 3:
        title = "Error";
        icon = Icons.error;
        break;

      case 4:
        title = "Info";
        icon = Icons.info;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Column(
        children: [
          Icon(
            icon,
            color: widget.type != 2 ? Colors.red : Colors.green,
            size: 40,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(widget.message),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: widget.onCancelPressed, child: const Text("Cancel")),
            TextButton(
              onPressed: widget.onOkPressed,
              child: const Text('OK'),
            ),
          ],
        )
      ],
    );
  }
}
