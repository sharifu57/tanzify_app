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
    final fullHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      child: SizedBox(
        height: fullHeight,
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                'assets/img/img1.json',
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Column(
                children: [
                  Text(
                    'Find great work',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      Text('Meet clients you are excited to work with'),
                      Text('and grow your independent business.'),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
