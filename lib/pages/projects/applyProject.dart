import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplyProject extends StatefulWidget {
  int? projectId;
  String? projectTitle;

  ApplyProject(
      {super.key, required this.projectId, required this.projectTitle});

  @override
  State<ApplyProject> createState() => _ApplyProjectState();
}

class _ApplyProjectState extends State<ApplyProject> {
  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
          title: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.projectTitle ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 40),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text("Submit Proposal"),
                )
              ],
            ),
          ),
        ));
  }
}
