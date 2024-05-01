import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tanzify_app/pages/authentication/components/intoScreens/intro_screen_one.dart';
import 'package:tanzify_app/pages/authentication/components/intoScreens/intro_screen_three.dart';

import 'intoScreens/into_screen_two.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [IntroPage1(), IntroPage2(), IntroPage3()],
        ),
        Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(2);
                  },
                  child: const Text("Skip"),
                ),
                SmoothPageIndicator(controller: _pageController, count: 3),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text("Done"),
                      )
                    : GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text("Next"),
                      ),
              ],
            ))
      ],
    ));
    // return Scaffold(
    //   body: SizedBox(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         PageView(
    //           controller: _pageController,
    //           onPageChanged: (int page) {
    //             setState(() {
    //               _currentPage = page;
    //             });
    //           },
    //           children: [
    //             Container(
    //               child: Text("Hello"),
    //             ),
    //             Container(
    //               child: Text("Two"),
    //             )
    //           ],
    //         ),

    //         //   children: <Widget>[
    //         //     buildPage(
    //         //       icon: Icons.flutter_dash,
    //         //       text: 'Welcome to Flutter',
    //         //       detail: 'This is an introduction to Flutter',
    //         //     ),
    //         //     buildPage(
    //         //       icon: Icons.code,
    //         //       text: 'Start Coding',
    //         //       detail: 'Learn to build apps',
    //         //     ),
    //         //   ],
    //         // ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: List.generate(2, (index) => buildDot(index, context)),
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             if (_currentPage == 1) {
    //               Navigator.push(context,
    //                   MaterialPageRoute(builder: (context) => FirstScreen()));
    //             } else {
    //               _pageController.nextPage(
    //                 duration: const Duration(milliseconds: 400),
    //                 curve: Curves.easeInOut,
    //               );
    //             }
    //           },
    //           child: Text(_currentPage == 1 ? 'Get Started' : 'Next'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget buildPage(
      {required IconData icon, required String text, required String detail}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 100, color: Theme.of(context).primaryColor),
          const SizedBox(height: 20),
          Text(text,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(detail, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: const Center(
        child: Text('You are on the first screen!'),
      ),
    );
  }
}
