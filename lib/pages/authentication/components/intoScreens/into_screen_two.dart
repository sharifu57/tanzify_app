import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.blue,
        child: Center(
      child: Lottie.asset(
        'assets/img/img2.json',
        repeat: true,
        fit: BoxFit.contain,
      ),
    ));
  }
}
