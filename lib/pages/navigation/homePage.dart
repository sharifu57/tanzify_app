import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // final Function(int)? goToPage;
  // const HomePage({super.key, required this.goToPage});
  final Function(int)? goToPage;

  const HomePage({Key? key, this.goToPage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void handlePageChange(int page) {
    if (widget.goToPage != null) {
      widget.goToPage!(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(),
    );
  }
}
