import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/components/containers/statusWidget.dart';
import 'package:tanzify_app/components/empty/emptyData.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/projects/openMyProject.dart';
import 'package:tanzify_app/services/userService.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyProjects extends StatefulWidget {
  const MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  int? userId;
  String userIdString = '';

  Future<void> loadUserId() async {
    final user = await UserService.getUserFromStorage();

    if (user != null) {
      setState(() {
        userId = user['id'];
        userIdString = userId != null ? userId.toString() : '';
      });
    }

    fetchMyProjects();
  }

  Future<void> fetchMyProjects() async {
    if (userId != null) {
      await Provider.of<ProjectProvider>(context, listen: false)
          .getMyProjects(userId!);
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.myProjects;

    final isLoading = projectProvider.isLoading;
    return Scaffold(
        body: SizedBox(
      child: isLoading
          ? const Center(
              child: WaveSpinKit(),
            )
          : RefreshIndicator(
              onRefresh: _handleRefresh,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Flexible(
                    child: projects.isNotEmpty
                        ? ListView.builder(
                            itemCount: projects.isEmpty ? 0 : projects.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => OpenMyProject(
                                              projectId: projects[index]['id']
                                                  .toString())));
                                },
                                child: Card(
                                    elevation: 1,
                                    shadowColor: Constants.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Created: ",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    timeago.format(
                                                        DateTime.parse(
                                                            projects[index]
                                                                ['created'])),
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 8),
                                                  StatusWidget(
                                                      status:
                                                          "${projects[index]['status']}")
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              projects[index]['title'] ?? '',
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: SizedBox(
                                                child: ReadMoreText(
                                              textAlign: TextAlign.start,
                                              projects[index]["description"] ??
                                                  "",
                                              trimMode: TrimMode.Line,
                                              trimLines: 4,
                                              colorClickableText: Colors.pink,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                              moreStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Constants.primaryColor),
                                            )),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          const Divider(),
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Text("Proposals:"),
                                                Text(
                                                    "${projects[index]['bids'].length}")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            })
                        : const Center(child: EmptyData())),
              )),
    ));
  }

  Future<void> _handleRefresh() async {
    try {
      await fetchMyProjects();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to refresh: $error'),
        ),
      );
    }
  }
}
