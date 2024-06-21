import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/pages/authentication/components/onBoardScreen.dart';
import 'package:tanzify_app/pages/authentication/login.dart';
import 'package:tanzify_app/pages/authentication/register.dart';
import 'package:tanzify_app/pages/authentication/verification.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/mainApp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Constants.primaryColor,
      minimumSize: const Size(88, 46),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: loading
            ? Center(
                child: SizedBox(height: fullHeight, child: const WaveSpinKit()))
            : SizedBox(
                height: fullHeight,
                child: Column(
                  children: [
                    SizedBox(
                      height: fullHeight / 4,
                      child: const Center(child: AppLogo()),
                    ),
                    Expanded(
                      child: Container(
                          color: Colors.white, child: const OnBoard()),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: raisedButtonStyle,
                                onPressed: () {
                                  navigateToPage(pathName: 'login');
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Dont have an account?"),
                                  TextButton(
                                      onPressed: () {
                                        navigateToPage(pathName: 'register');
                                      },
                                      child: const Text(
                                        "Register",
                                        style: TextStyle(
                                            color: Constants.primaryColor,
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ));
  }

  navigateToPage({required final String pathName}) async {
    if (pathName == 'login') {
      await Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => const LoginPage()));
    } else if (pathName == 'register') {
       Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => const RegisterPage()));
    }
  }
}
