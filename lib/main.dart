import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/data/providers/userProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/splashScreen.dart';
import 'package:tanzify_app/services/dataConnection.dart';

void main() => runApp(const TanzifyApp());

class TanzifyApp extends StatefulWidget {
  const TanzifyApp({super.key});

  @override
  State<TanzifyApp> createState() => _TanzifyAppState();
}

class _TanzifyAppState extends State<TanzifyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DataConnection(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(create: (context) => CategoryProvider())
        ],
        child: MaterialApp(
          navigatorKey: Constants.globalAppKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // theme: ThemeData(brightness: Brightness.dark),
          home: const SplashScreen(),
        ));
  }
}
