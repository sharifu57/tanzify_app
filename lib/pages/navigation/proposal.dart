import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/appBar/appBar.dart';
import 'package:tanzify_app/components/icons/simpleIcon.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/projects/appliedBid.dart';
import 'package:tanzify_app/pages/projects/myProjects.dart';

class Proposal extends StatefulWidget {
  const Proposal({super.key});

  @override
  State<Proposal> createState() => _ProposalState();
}

class _ProposalState extends State<Proposal> {
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
    final double fullHeight = MediaQuery.of(context).size.height;
    final projectProvider = Provider.of<ProjectProvider>(context);
    final isLoading = projectProvider.isLoading;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: const Text("Proposals",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              // SizedBox(height: 10),
              const TabBar(
                tabs: [
                  Tab(
                    text: "Applied",
                  ),
                  Tab(
                    text: "Created by Me",
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [AppliedBid(), MyProjects()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
