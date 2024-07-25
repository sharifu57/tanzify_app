import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
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
    getProjects();
  }

  Future<void> getProjects() async {
    await Provider.of<ProjectProvider>(context, listen: false)
        .getSystemProjects();
  }

  @override
  void initState() {
    getUserFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.systemProjects;

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
                        Container(
                          child: Text("One"),
                        )
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
                              child: _buildChart(),
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Total Users',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontSize: 11.sp,
                                            ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Card(
                                      child: Text('One'),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return BarChart(
      BarChartData(
        barGroups: _getData(),
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

  List<BarChartGroupData> _getData() {
    return [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(fromY: 0, toY: 8)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(fromY: 0, toY: 10)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(fromY: 0, toY: 14)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(fromY: 0, toY: 15)]),
      BarChartGroupData(x: 4, barRods: [BarChartRodData(fromY: 0, toY: 13)]),
      BarChartGroupData(x: 5, barRods: [BarChartRodData(fromY: 0, toY: 10)]),
    ];
  }
}
