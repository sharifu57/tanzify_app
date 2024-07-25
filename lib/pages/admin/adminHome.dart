// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';

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
    // TODO: implement initState
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
        child: Column(
          children: [
            Container(
                height: fullHeight / 2.3,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // color: Constants.primaryColor,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Constants.primaryColor,
                      Constants.accentColor
                    ])),
                child: Container(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: const Text(
                                  "Welcome",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${(firstName ?? '').isNotEmpty ? firstName!.toUpperCase() : ''} ${(lastName ?? '').isNotEmpty ? lastName!.toUpperCase() : ''}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                                        ? Text(email![0].toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12))
                                        : Text(
                                            '${(firstName ?? '').isNotEmpty ? firstName![0].toUpperCase() : ''}${(lastName ?? '').isNotEmpty ? lastName![0].toUpperCase() : ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Chip(
                        elevation: 20,
                        padding: EdgeInsets.all(8),
                        shadowColor: Colors.black,
                        avatar: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
                        ), //CircleAvatar
                        label: Column(
                          children: [
                            const Text(
                              'System Projects',
                            ),
                            Text(
                              "${projects.length}",
                            )
                          ],
                        ), //Text
                      ),
                    )
                  ],
                ))),
            Expanded(child: Container())
          ],
        ),
      )),
    );
  }
}
