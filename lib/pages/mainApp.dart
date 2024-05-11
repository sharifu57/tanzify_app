import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/navigation/alertPage.dart';
import 'package:tanzify_app/pages/navigation/application.dart';
import 'package:tanzify_app/pages/navigation/homePage.dart';
import 'package:tanzify_app/pages/navigation/post.dart';
import 'package:tanzify_app/pages/navigation/profile.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var pages = [
      HomePage(goToPage: (page) {
        setState(() {
          currentPageIndex = page;
        });
      }),
      const ApplicationPage(),
      const JobPosting(),
      const AlertPage(),
      const Profile()
    ];
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.05,
            ),
          ),
        ),
        child: NavigationBar(
          height: 60,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.work_history_outlined),
              label: 'Projects',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.tips_and_updates),
              icon: Icon(Icons.document_scanner_outlined),
              label: 'Add New',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_sharp),
              label: 'Alert',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_2),
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
