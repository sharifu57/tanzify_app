import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/projects/viewProject.dart';
import 'package:tanzify_app/pages/searchScreen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:readmore/readmore.dart';

class HomePage extends StatefulWidget {
  // final Function(int)? goToPage;
  // const HomePage({super.key, required this.goToPage});
  final Function(int)? goToPage;

  const HomePage({Key? key, this.goToPage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int notificationCount = 1;
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
    // Provider.of<ProjectProvider>(context, listen: false).getProjects();

    fetchProjects();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Provider.of<ProjectProvider>(context, listen: false).getProjects();
      fetchProjects();
    }
  }

  Future<void> fetchProjects() async {
    await Provider.of<ProjectProvider>(context, listen: false).getProjects();
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final isLoading = projectProvider.isLoading;
    final double fullHeight = MediaQuery.of(context).size.height;
    final projects = projectProvider.projectsList;

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
              child: CircleAvatar(
                backgroundColor: Colors.brown.shade800,
                child: const Text('AH'),
              ),
            ),
          ),
          // Example count of notifications

          actions: [
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
                    // padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
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
                    icon: const Icon(Icons.message_outlined),
                    iconSize: 20,
                    onPressed: () {},
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
                      child: Text(
                        '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: WaveSpinKit())
            : RefreshIndicator(
                onRefresh: _handleRefresh,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text("Projects",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      const Divider(color: Constants.borderColor),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: const SearchScreen()),
                      const Divider(color: Constants.borderColor),
                      Flexible(
                          child: ListView.builder(
                              itemCount: projects.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    ViewProject(
                                                        project:
                                                            projects[index])));
                                      },
                                      child: SizedBox(
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
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
                                                  Row(
                                                    children: [
                                                      Text(
                                                        projects[index]
                                                            .budget!
                                                            .price_from,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text("-"),
                                                      Text(
                                                        projects[index]
                                                            .budget!
                                                            .price_to,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  )
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
                                                  ),
                                                )),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Wrap(
                                                    runAlignment:
                                                        WrapAlignment.start,
                                                    spacing: 4.0,
                                                    runSpacing: 6.0,
                                                    children: projects[index]
                                                            .skills
                                                            ?.map((skill) =>
                                                                ChoiceChip(
                                                                  label: Text(
                                                                      skill
                                                                          .name),
                                                                  selected:
                                                                      true,
                                                                ))
                                                            .toList() ??
                                                        [
                                                          const Chip(
                                                            label: Text(""),
                                                          )
                                                        ]),
                                              ),
                                              Container(
                                                child: Row(
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
                                                              .name)
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
                                                ),
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
                              }))
                    ],
                  ),
                ),
              ));
  }

  Future<void> _handleRefresh() async {
    // await Future.delayed(const Duration(seconds: 2));
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

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  child: const Icon(Icons.keyboard_arrow_left,
                      color: Colors.black),
                ),
                const Text('Back',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
              ],
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
