import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tanzify_app/components/empty/emptyData.dart';
import 'package:tanzify_app/pages/projects/addNew.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => const AddNewProject()));
          }),
      body: const Center(child: EmptyData()),
    );
  }
}
