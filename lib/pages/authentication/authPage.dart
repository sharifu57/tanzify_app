import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/authentication/components/onBoardScreen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: fullHeight,
          child: Column(
            children: [
              SizedBox(
                height: fullHeight / 4,
                child: const Center(child: Text('Logo')),
              ),
              const Expanded(
                child: OnBoard(),
              ),
              Container(child: Text(''))
            ],
          ),
        ));
  }
}
