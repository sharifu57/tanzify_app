import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanzify_app/pages/constants.dart';

class AssessProject extends StatefulWidget {
  final String projectId;
  final String title;

  const AssessProject(
      {super.key, required this.projectId, required this.title});

  @override
  State<AssessProject> createState() => _AssessProjectState();
}

class _AssessProjectState extends State<AssessProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 0.h),
          AppBar(
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(
            //       bottomRight: Radius.circular(25),
            //       bottomLeft: Radius.circular(25)),
            // ),
            elevation: 0.00,
            backgroundColor: Constants.primaryColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                  color: Colors.white,
                )),
            title: Center(
              child: Text(
                "${widget.title}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
            actions: [
              Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: const Center(
                    child: Icon(
                      Icons.search,
                      color: Constants.accentColor,
                    ),
                  ))
            ],
          )
        ],
      )),
    );
  }
}
