import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/img/logo.png',
        fit: BoxFit.contain,
      ),
      // child: Text('Logo'),
    );
  }
}
