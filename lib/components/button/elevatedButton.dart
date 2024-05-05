import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';

class ButtonElevated extends StatelessWidget {
  final String text;
  final VoidCallback buttonPressed;
  final Color color;
  final TextStyle textStyle;

  const ButtonElevated(
      {super.key,
      required this.text,
      required this.buttonPressed,
      required this.color,
      required this.textStyle,
      required});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Constants.primaryColor,
      minimumSize: const Size(88, 46),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    );
    return ElevatedButton(
        // style: raisedButtonStyle,
        onPressed: buttonPressed,
        child: Text(
          text,
          style: textStyle,
        ));
  }
}
