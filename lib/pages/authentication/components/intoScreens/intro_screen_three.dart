import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Lottie.asset(
              'assets/img/img3.json',
              repeat: true,
              fit: BoxFit.contain,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Column(
                children: [
                  Text(
                    'Complete your profile',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [Text('Let your profile speaks for it self')],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
