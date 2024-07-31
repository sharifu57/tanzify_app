import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tanzify_app/components/containers/statusWidget.dart';
import 'package:tanzify_app/components/profile/profileWidget.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/data/providers/userProvider.dart';
import 'package:tanzify_app/pages/admin/assessProject.dart';
import 'package:tanzify_app/pages/admin/seeAllProjects.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String? firstName;
  String? lastName;
  String? profileImage;
  String? email;

  void getUserFromStorage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? user = prefs.getString('user');

      if (user != null) {
        final userData = jsonDecode(user);
        final dynamic userIdData = userData["id"];

        if (userIdData != null) {
          setState(() {
            firstName = userData["first_name"];
            lastName = userData["last_name"];
            profileImage = userData['profile']['profile_image'];
            email = userData["email"];
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading user from storage: $e");
    }
  }

  Future<void> getProjects() async {
    print("-----here1");
    try {
      print("=====hre 2");
      await Provider.of<ProjectProvider>(context, listen: false)
          .getSystemProjects();
      print("=----here 3");
    } catch (e) {
      debugPrint("Error loading projects: $e");
    }
  }

  Future<void> getUsers() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).getUsers();
    } catch (e) {
      debugPrint("Error loading users: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserFromStorage();
      getProjects();
      getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.systemProjects;
    final userProvider = Provider.of<UserProvider>(context);
    final users = userProvider.sysUsers;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: fullHeight,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: fullHeight / 5.5,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Constants.primaryColor, Constants.accentColor],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Welcome",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  Text(
                                    '${(firstName ?? '').isNotEmpty ? firstName!.toUpperCase() : ''} ${(lastName ?? '').isNotEmpty ? lastName!.toUpperCase() : ''}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const Spacer(), // Add a spacer to push the profile image to the right
                              Container(
                                padding: const EdgeInsets.all(1),
                                child: profileImage != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(profileImage!),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Constants.accentColor,
                                        child: email != null
                                            ? Text(
                                                email![0].toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                              )
                                            : Text(
                                                '${(firstName ?? '').isNotEmpty ? firstName![0].toUpperCase() : ''}${(lastName ?? '').isNotEmpty ? lastName![0].toUpperCase() : ''}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: fullHeight / 5.5 - 40, // Adjust this value as needed
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Projects Analytics',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Annual analysis",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                                const Text('Filter'),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              height: 200, // Adjust the height as needed
                              child: _buildChart(projects),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'System Users',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Total",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${users.length}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    const Icon(
                                                      LineAwesomeIcons
                                                          .arrow_up_solid,
                                                      size: 15,
                                                      color:
                                                          Constants.accentColor,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'All Projects',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Total",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${projects.length}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    const Icon(
                                                      LineAwesomeIcons
                                                          .wolf_pack_battalion,
                                                      size: 15,
                                                      color:
                                                          Constants.accentColor,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Projects',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                              TextButton(
                                onPressed: () {
                                  debugPrint("See All Buttons");
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => SeeAllProjects()));
                                },
                                child: Text(
                                  'See All',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Constants.primaryColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: 200,
                              child: Skeletonizer(
                                enabled: projectProvider.isLoading,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: projects.isEmpty
                                        ? 0
                                        : (projects.length >= 3
                                            ? 3
                                            : projects.length),
                                    itemBuilder: (context, index) {
                                      // Adjust the index to get the last three projects
                                      int adjustedIndex =
                                          projects.length - 1 - index;
                                      return Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Card(
                                            elevation: 3,
                                            child: InkWell(
                                              splashColor:
                                                  Constants.primaryColor,
                                              onTap: () {
                                                Navigator.of(context).push(CupertinoPageRoute(
                                                    builder: (context) => AssessProject(
                                                        projectId: projects[index]['id']
                                                            .toString(),
                                                        projectCreated:
                                                            projects[index]['created']
                                                                .toString(),
                                                        projectStatus:
                                                            projects[index]['status']
                                                                .toString(),
                                                        title: projects[index]
                                                            ['title'],
                                                        projectDescription:
                                                            projects[index]
                                                                ['description'],
                                                        duration: projects[index]
                                                                ['duration'] ??
                                                            {},
                                                        bids: projects[index]['bids'] ?? [],
                                                        budget: projects[index]['budget'] ?? {},
                                                        category: projects[index]['category'] ?? {},
                                                        skills: projects[index]['skills'] ?? [],
                                                        freelancer: projects[index]['created_by'] ?? {})));
                                              },
                                              child: ListTile(
                                                leading: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: const Icon(
                                                    LineAwesomeIcons
                                                        .wolf_pack_battalion,
                                                    color:
                                                        Constants.primaryColor,
                                                    size: 18,
                                                  ),
                                                ),
                                                title: Text(
                                                    "${projects[adjustedIndex]['title']}"),
                                                trailing: SizedBox(
                                                  width:
                                                      70, // Adjust the width as needed
                                                  child: Center(
                                                    child: StatusWidget(
                                                        status:
                                                            "${projects[adjustedIndex]['status']}"),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      );
                                    }),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(List<dynamic> projects) {
    return BarChart(
      BarChartData(
        barGroups: _getData(projects),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getData(List<dynamic> projects) {
    List<BarChartGroupData> barChartGroups = [];

    for (int i = 0; i < projects.length; i++) {
      final project = projects[i];
      final String amountStr = project['amount'] ?? '10.0';
      final double value = double.tryParse(amountStr) ??
          10.0; // Replace 'someValue' with the relevant key

      barChartGroups.add(
        BarChartGroupData(
            x: i, barRods: [BarChartRodData(fromY: 0, toY: value)]),
      );
    }

    return barChartGroups;
  }
}
