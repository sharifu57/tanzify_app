import 'package:flutter/material.dart';
import 'package:tanzify_app/models/project/projectModal.dart';

class ViewProject extends StatefulWidget {
  const ViewProject({super.key, required ProjectModel project});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
