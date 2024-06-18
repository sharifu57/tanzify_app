import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    child: Center(
        child: Lottie.asset(
          'assets/img/empty.json',
          repeat: true,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}