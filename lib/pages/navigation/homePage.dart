import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/homePage/employerHome.dart';
import 'package:tanzify_app/pages/homePage/freelancerHome.dart';
import 'package:tanzify_app/pages/message/chats.dart';

class HomePage extends StatefulWidget {
  final Function(int)? goToPage;

  const HomePage({super.key, this.goToPage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int notificationCount = 1;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? email;
  int? userId;
  int? categoryId;
  String? userIdString;
  String? categoryIdString;
  String? userCategory;
  int? userType;
  late ScrollController _scrollController;

  void handlePageChange(int page) {
    if (widget.goToPage != null) {
      widget.goToPage!(page);
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    getUserFromStorage();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchProjects();
    }
  }

  Future<void> fetchProjects() async {
    if (categoryId != null) {
      await Provider.of<ProjectProvider>(context, listen: false)
          .getProjects(categoryId!);
    }
  }

  void getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    // await prefs.clear();

    if (user != null) {
      final userData = jsonDecode(user);
      final dynamic userIdData = userData["id"];
      final dynamic categoryIdData = userData['profile']['category']?['id'];

      // if (userData['profile']['category']['id'] != null) {}

      if (userIdData != null) {
        setState(() {
          firstName = userData["first_name"];
          lastName = userData["last_name"];
          profileImage = userData['profile']['profile_image'];
          userType = userData['profile']['user_type'];
          email = userData["email"];
          userId = int.tryParse(userIdData.toString());
          userIdString = userId != null ? userId.toString() : '';
          categoryId = int.tryParse(categoryIdData.toString());
          categoryIdString = categoryId != null ? categoryId.toString() : '';
        });

        fetchProjects();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: const EdgeInsets.only(left: 17),
          child: Container(
            width: 10,
            height: 10,
            padding: const EdgeInsets.all(1),
            child: profileImage != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(profileImage!),
                  )
                : CircleAvatar(
                    backgroundColor: Constants.primaryColor,
                    child: email != null
                        ? Text(
                            email![0].toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          )
                        : Text(
                            '${(firstName ?? '').isNotEmpty ? firstName![0] : ''}${(lastName ?? '').isNotEmpty ? lastName![0] : ''}',
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                      ),
                      iconSize: 20,
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 4,
                      top: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            '$notificationCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 14),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.telegram_outlined),
                        iconSize: 20,
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const Chats()));
                        },
                      ),
                      Positioned(
                        right: 4,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 10,
                          ),
                          child: Center(
                            child: Text(
                              '$notificationCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: userType == 1 ? const FreelancerHome() : const EmployerHome(),
    );
  }
}
