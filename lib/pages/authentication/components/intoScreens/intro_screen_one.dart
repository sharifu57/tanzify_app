import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.blue,
        child: Center(
      child: Lottie.asset(
        'assets/img/img1.json',
        repeat: true,
        fit: BoxFit.contain,
      ),
    ));
  }
}
