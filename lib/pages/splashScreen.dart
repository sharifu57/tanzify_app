import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/authentication/authPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initialStage();
    super.initState();
  }

  void initialStage() async {
    await Future.delayed(const Duration(seconds: 3));
    openAndNavigate();
  }

  void openAndNavigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: "/"),
        builder: (context) => const AuthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplashScreen();
  }
}

Widget _buildSplashScreen() {
  return Material(
    color: Colors.white,
    child: Center(
      child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(20),
          child: const Text("Logo Here")),
    ),
  );
}
