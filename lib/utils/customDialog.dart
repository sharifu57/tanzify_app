import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';

class CustomDialog extends StatefulWidget {
  final String message;
  final VoidCallback? onOkPressed;
  final VoidCallback? onCancelPressed;
  final int type;

  const CustomDialog({
    super.key,
    required this.message,
    required this.onOkPressed,
    required this.onCancelPressed,
    required this.type,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late IconData icon;
  late String title;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // insetAnimationDuration: const Duration(milliseconds: 100),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: widget.type != 2 ? Colors.red : Colors.green,
              size: 40,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            widget.type == 4 || widget.type == 2
                ? Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Constants.tertiaryColor,
                        foregroundColor: Colors.white,
                        elevation: 1,
                      ),
                      onPressed: widget.onOkPressed,
                      child: const Text('Okay'),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Constants.errorColor,
                          foregroundColor: Colors.white,
                          elevation: 1,
                        ),
                        onPressed: widget.onCancelPressed,
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Constants.tertiaryColor,
                          foregroundColor: Colors.white,
                          elevation: 1,
                        ),
                        onPressed: widget.onOkPressed,
                        child: const Text('OK'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context, CustomDialog customDialog) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: customDialog,
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.bounceInOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0, -1.0),
          end: const Offset(0, 0),
        )),
        child: child,
      );
    },
  );
}
