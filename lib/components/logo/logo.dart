import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        // child: Image.asset('assets/img/logo.png'),
        child: Text('Logo'),
      ),
    );
  }
}
