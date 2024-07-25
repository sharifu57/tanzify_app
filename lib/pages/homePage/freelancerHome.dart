import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/homePage/allProjects.dart';
import 'package:tanzify_app/pages/homePage/bestMatch.dart';
import 'package:tanzify_app/pages/projects/addNew.dart';
import 'package:tanzify_app/pages/searchScreen.dart';

class FreelancerHome extends StatefulWidget {
  const FreelancerHome({super.key});

  @override
  State<FreelancerHome> createState() => _FreelancerHomeState();
}

class _FreelancerHomeState extends State<FreelancerHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Projects",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  CircleAvatar(
                    backgroundColor: Constants.primaryColor,
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => const AddNewProject()));
                          },
                          icon: const Icon(
                            LineAwesomeIcons.plus_circle_solid,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
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
