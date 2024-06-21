import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/components/empty/emptyData.dart';
import 'package:tanzify_app/components/icons/simpleIcon.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/projects/viewProject.dart';
import 'package:tanzify_app/pages/searchScreen.dart';
import 'package:timeago/timeago.dart' as timeago;

class FreelancerHome extends StatefulWidget {
  const FreelancerHome({super.key});

  @override
  State<FreelancerHome> createState() => _FreelancerHomeState();
}

class _FreelancerHomeState extends State<FreelancerHome> {
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

  // void handlePageChange(int page) {
  //   if (widget.goToPage != null) {
  //     widget.goToPage!(page);
  //   }
  // }

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
      final dynamic categoryIdData = userData['profile']['category']['id'];

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

    print("=====prifle image");
    print(profileImage);
    print("=====end profile image");
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final isLoading = projectProvider.isLoading;
    final projects = projectProvider.projectsList;

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 10),
              child: const Text("Projects",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            ),
            const Divider(color: Constants.borderColor),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const SearchScreen()),
            const Divider(color: Constants.borderColor),
            Flexible(
                child: projects.isEmpty
                    ? const Center(
                        child: EmptyData(),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: projects.isEmpty ? 0 : projects.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: projects[index].bids != null &&
                                        projects[index].bids!.isNotEmpty &&
                                        projects[index].bids![0].identity ==
                                            userIdString
                                    ? () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                "You have already bid on this project"),
                                          ),
                                        );
                                      }
                                    : () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    ViewProject(
                                                        project:
                                                            projects[index])));
                                      },
                                child: isLoading
                                    ? const Center(child: WaveSpinKit())
                                    : SizedBox(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Posted ",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      Text(
                                                        projects[index]
                                                                    .created !=
                                                                null
                                                            ? timeago.format(
                                                                DateTime.parse(
                                                                    projects[
                                                                            index]
                                                                        .created!))
                                                            : "Date not available",
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      child: projects[index]
                                                              .bids!
                                                              .isNotEmpty
                                                          ? projects[index]
                                                                      .bids![0]
                                                                      .identity ==
                                                                  userIdString
                                                              ? Card(
                                                                  elevation: 0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    side: const BorderSide(
                                                                        color: Constants
                                                                            .successColor),
                                                                  ),
                                                                  child:
                                                                      const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: Row(
                                                                      children: [
                                                                        SimpleIcon(
                                                                            size:
                                                                                11,
                                                                            color:
                                                                                Constants.successColor,
                                                                            icon: Icons.verified_user_outlined),
                                                                        SizedBox(
                                                                            width:
                                                                                8),
                                                                        Text(
                                                                          "Applied",
                                                                          style: TextStyle(
                                                                              color: Constants.successColor,
                                                                              fontSize: 11),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ))
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                      projects[
                                                                              index]
                                                                          .budget!
                                                                          .price_from as String,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                        "-"),
                                                                    Text(
                                                                      projects[
                                                                              index]
                                                                          .budget!
                                                                          .price_to as String,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                          : Container(
                                                              child: projects[index]
                                                                          .budget
                                                                          ?.price_to !=
                                                                      null
                                                                  ? Row(
                                                                      children: [
                                                                        Text(
                                                                          projects[index]
                                                                              .budget!
                                                                              .price_from as String,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        const Text(
                                                                            "-"),
                                                                        Text(
                                                                          projects[index]
                                                                              .budget!
                                                                              .price_to as String,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : null))
                                                ],
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      projects[index].title ??
                                                          "No title",
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Text("")
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: SizedBox(
                                                    child: ReadMoreText(
                                                  textAlign: TextAlign.start,
                                                  projects[index].description ??
                                                      "",
                                                  trimMode: TrimMode.Line,
                                                  trimLines: 4,
                                                  colorClickableText:
                                                      Colors.pink,
                                                  trimCollapsedText:
                                                      'Show more',
                                                  trimExpandedText: 'Show less',
                                                  moreStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Constants
                                                          .primaryColor),
                                                )),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: projects[index]
                                                            .skills
                                                            ?.map((skill) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                        4.0), // Add some spacing
                                                            child: ChoiceChip(
                                                              label: Text(
                                                                  skill.name),
                                                              selected: true,
                                                            ),
                                                          );
                                                        }).toList() ??
                                                        [
                                                          const Chip(
                                                              label: Text(""))
                                                        ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          'assets/img/flag.png',
                                                          fit: BoxFit.contain,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              6,
                                                        ),
                                                        Text(projects[index]
                                                                .location!
                                                                .name ??
                                                            '')
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                      "${projects[index].bids?.length ?? 0} Proposals",
                                                      style: const TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                              const Divider(
                                color: Constants.borderColor,
                              )
                            ],
                          );
                        })),
          ],
        ),
      ),
    ));
  }

  Future<void> _handleRefresh() async {
    try {
      await fetchProjects();
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to refresh: $error'),
        ),
      );
    }
  }
}
