import 'package:flutter/material.dart';
import 'package:tanzify_app/components/icons/simpleIcon.dart';
import 'package:tanzify_app/pages/navigation/homePage.dart';
import 'package:tanzify_app/pages/navigation/NewProject.dart';
import 'package:tanzify_app/pages/navigation/profile.dart';
import 'package:tanzify_app/pages/navigation/proposal.dart';

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
      const Proposal(),
      const NewProject(),
      // const AlertPage(),
      const Profile()
    ];
    return Scaffold(
      body: pages[currentPageIndex],
      // floatingActionButton:
      //     FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.05,
            ),
          ),
        ),
        child: NavigationBar(
          height: 55,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                size: 18,
              ),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.document_scanner_rounded,
                size: 18,
              ),
              icon: SimpleIcon(icon: Icons.document_scanner_outlined),
              label: 'Proposals',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.history,
                size: 18,
              ),
              icon: Icon(
                Icons.history_sharp,
              ),
              label: 'Alert',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person_2,
                size: 18,
              ),
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
