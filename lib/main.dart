import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/splashScreen.dart';

void main() => runApp(const TanzifyApp());

class TanzifyApp extends StatefulWidget {
  const TanzifyApp({super.key});

  @override
  State<TanzifyApp> createState() => _TanzifyAppState();
}

class _TanzifyAppState extends State<TanzifyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Constants.globalAppKey,
        debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
