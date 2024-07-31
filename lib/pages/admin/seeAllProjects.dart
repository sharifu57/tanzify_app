import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tanzify_app/components/containers/searchBarApp.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/admin/assessProject.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;

class SeeAllProjects extends StatefulWidget {
  const SeeAllProjects({super.key});

  @override
  State<SeeAllProjects> createState() => _SeeAllProjectsState();
}

class _SeeAllProjectsState extends State<SeeAllProjects> {
  bool _isLoading = true;
  bool _isLoadingMore = false;
  final int _pageSize = 10;
  int _currentPage = 1;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startLoadingTimer();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startLoadingTimer() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _loadMoreItems(ProjectProvider projectProvider) {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });

    projectProvider.fetchMoreProjects(_pageSize, _currentPage).then((_) {
      setState(() {
        _currentPage++;
        _isLoadingMore = false;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500 && !_isLoadingMore) {
      final projectProvider =
          Provider.of<ProjectProvider>(context, listen: false);
      _loadMoreItems(projectProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final projects = projectProvider.systemProjects;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_sharp,
            size: 24,
            color: Constants.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Projects',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const SearchBarApp(),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                sliver: Skeletonizer.sliver(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Card(
                          child: ListTile(
                            title: Container(
                              width: double.infinity,
                              height: 20.0,
                              color: Colors.grey[300],
                            ),
                            subtitle: Container(
                              width: double.infinity,
                              height: 20.0,
                              color: Colors.grey[300],
                            ),
                            trailing: const Icon(Icons.ac_unit),
                          ),
                        );
                      },
                      childCount: _pageSize,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == projects.length) {
                        return const Center(child: WaveSpinKit());
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => AssessProject(
                                  projectId: projects[index]['id'].toString(),
                                  projectCreated:
                                      projects[index]['created'].toString(),
                                  projectStatus:
                                      projects[index]['status'].toString(),
                                  title: projects[index]['title'],
                                  projectDescription: projects[index]
                                      ['description'],
                                  duration: projects[index]['duration'] ?? {},
                                  bids: projects[index]['bids'] ?? [],
                                  budget: projects[index]['budget'] ?? {},
                                  category: projects[index]['category'] ?? {},
                                  skills: projects[index]['skills'] ?? [],
                                  freelancer:
                                      projects[index]['created_by'] ?? {})));
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Posted ",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          projects[index]['created'] != null
                                              ? timeago.format(DateTime.parse(
                                                  projects[index]['created']!))
                                              : "Date not available",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            projects[index]['title'] ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(),
                                          )),
                                    ),
                                    SizedBox(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: SizedBox(
                                            child: ReadMoreText(
                                          textAlign: TextAlign.justify,
                                          projects[index]['description'] ?? "",
                                          trimMode: TrimMode.Line,
                                          trimLines: 4,
                                          colorClickableText: Colors.pink,
                                          trimCollapsedText: 'Show more',
                                          trimExpandedText: 'Show less',
                                          moreStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Constants.primaryColor),
                                        )),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: (projects[index]['skills']
                                                  as List)
                                              .map<Widget>((skill) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: ChoiceChip(
                                                label: Text(skill['name']),
                                                selected: true,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                'assets/img/flag.png',
                                                fit: BoxFit.contain,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6,
                                              ),
                                              Text(projects[index]
                                                      ['location']!['name'] ??
                                                  '')
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            "${projects[index]['bids']?.length ?? 0} Proposals",
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: projects.length + 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
