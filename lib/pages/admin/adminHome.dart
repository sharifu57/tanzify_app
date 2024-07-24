import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SizedBox(
      height: fullHeight,
      child: Column(
        children: [
          Container(
            height: fullHeight / 2.3,
            // color: Constants.primaryColor,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Constants.primaryColor, Constants.accentColor])),
          ),
          Expanded(child: Container())
        ],
      ),
    ));
  }
}
