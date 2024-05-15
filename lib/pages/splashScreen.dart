import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/pages/authentication/authPage.dart';
import 'package:tanzify_app/pages/mainApp.dart';
import 'package:tanzify_app/pages/navigation/homePage.dart';

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
    checkIsLoggInStatus();
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

  void checkIsLoggInStatus() {
    bool isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).accessToken != null;
    print("=================auth data");
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (builder) => isLoggedIn ? const MainApp() : const AuthPage()));
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
          child: const AppLogo()),
    ),
  );
}
