import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/components/containers/statusWidget.dart';
import 'package:tanzify_app/components/empty/emptyData.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
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
    int? id = await UserService.getUserFromStorage();
    setState(() {
      userId = id;
      userIdString = userId != null ? userId.toString() : '';
    });

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
                child: 
                Flexible()
                // Flexible(
                //     child: projects.isNotEmpty
                //         ? ListView.builder(
                //             itemCount: projects.isEmpty ? 0 : projects.length,
                //             itemBuilder: (context, index) {
                //               final bid =
                //                   projects[index] as Map<String, dynamic>;
                //               final project =
                //                   bid['project'] as Map<String, dynamic>?;
                //               return Card(
                //                 elevation: 0.4,
                //                 shadowColor: Constants.primaryColor,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Row(
                //                             children: [
                //                               const Text(
                //                                 "Bid Sent",
                //                                 style: TextStyle(fontSize: 10),
                //                               ),
                //                               Text(
                //                                 timeago.format(DateTime.parse(
                //                                     bid['created'])),
                //                                 style: const TextStyle(
                //                                     color: Colors.grey,
                //                                     fontSize: 10),
                //                               ),
                //                             ],
                //                           ),
                //                           Row(
                //                             children: [
                //                               // const SimpleIcon(
                //                               //     size: 11,
                //                               //     color: Constants.successColor,
                //                               //     icon: Icons
                //                               //         .verified_user_outlined),
                //                               const SizedBox(width: 8),
                //                               StatusWidget(
                //                                   status: "${bid['status']}")
                //                             ],
                //                           ),
                //                         ],
                //                       ),
                //                       Container(
                //                         alignment: Alignment.centerLeft,
                //                         child: Text(
                //                           project!['title'] ?? '',
                //                           style: const TextStyle(
                //                               fontSize: 13,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       ),
                //                       Container(
                //                         padding: const EdgeInsets.only(top: 5),
                //                         child: SizedBox(
                //                             child: ReadMoreText(
                //                           textAlign: TextAlign.start,
                //                           project["description"] ?? "",
                //                           trimMode: TrimMode.Line,
                //                           trimLines: 4,
                //                           colorClickableText: Colors.pink,
                //                           trimCollapsedText: 'Show more',
                //                           trimExpandedText: 'Show less',
                //                           moreStyle: const TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.bold,
                //                               color: Constants.primaryColor),
                //                         )),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             })
                //         : const Center(child: EmptyData())),
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
