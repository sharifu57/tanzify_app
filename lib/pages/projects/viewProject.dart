import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewProject extends StatefulWidget {
  final ProjectModel project;
  const ViewProject({super.key, required this.project});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    final projectProvider = Provider.of<ProjectProvider>(context);
    final isLoading = projectProvider.isLoading;
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
              widget.project.title ?? "Project Details",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 40),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: WaveSpinKit(),
            )
          : Container(
              height: fullHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        const Text(
                          "Posted ",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          widget.project.created != null
                              ? timeago.format(
                                  DateTime.parse(widget.project.created!))
                              : "Date not available",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 5),
                          alignment: Alignment.topLeft,
                          child: const Icon(
                            Icons.campaign_rounded,
                            color: Constants.primaryColor,
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(widget.project.description ?? ""),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
