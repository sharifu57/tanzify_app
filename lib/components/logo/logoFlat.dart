import 'package:flutter/material.dart';

class LogoFlat extends StatelessWidget {
  const LogoFlat({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/img/1x/logo.png',
        fit: BoxFit.contain,
      ),
      // child: Text('Logo'),
    );
    // return const Center(
    //   child: Text('Logo')
    // );
  }
}
