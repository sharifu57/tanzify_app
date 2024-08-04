import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/pages/authentication/authPage.dart';
import 'package:tanzify_app/pages/mainApp.dart';

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

  void checkIsLoggInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? accessToken = prefs.getString("accessToken");
    String? accessToken = prefs.getString("user");

    bool isLoggedIn = accessToken != null && accessToken.isNotEmpty;

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
      child: Column(
        children: [
          Expanded(
            child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(20),
                child: const AppLogo()),
          ),
          const Text("Version 1.0.0+1"),
        ],
      ),
    ),
  );
}
