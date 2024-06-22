import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/homePage/allProjects.dart';
import 'package:tanzify_app/pages/homePage/bestMatch.dart';
import 'package:tanzify_app/pages/searchScreen.dart';

class FreelancerHome extends StatefulWidget {
  const FreelancerHome({super.key});

  @override
  State<FreelancerHome> createState() => _FreelancerHomeState();
}

class _FreelancerHomeState extends State<FreelancerHome> {
  @override
  Widget build(BuildContext context) {
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
            const Flexible(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(
                          text: "Best Match",
                        ),
                        Tab(
                          text: "Most Recent",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [BestMatch(), AllProjects()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _handleRefresh() async {
    try {
      // await fetchProjects();
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
