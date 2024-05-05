import 'package:flutter/cupertino.dart';
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
    final fullHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      child: SizedBox(
        height: fullHeight,
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                'assets/img/img2.json',
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Column(
                children: [
                  Text(
                    'Find Opportunities',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      Text('Get notified every time a new project is created'),
                      Text('and be the first one to apply for it.'),
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
