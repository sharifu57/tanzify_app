import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/searchScreen.dart';

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
  void handlePageChange(int page) {
    if (widget.goToPage != null) {
      widget.goToPage!(page);
    }
  }

  @override
  void initState() {
    Provider.of<ProjectProvider>(context, listen: false).getProjects();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final isLoading = projectProvider.isLoading;
    final double fullHeight = MediaQuery.of(context).size.height;
    final projects = projectProvider.projectsList;

    print("==========projects");
    print(projects);
    print("=========end this my projects");
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
                iconSize: 22,
                onPressed: () {},
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
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
                      fontSize: 12,
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
                  iconSize: 22,
                  onPressed: () {},
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
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
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: fullHeight,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Projects",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Divider(color: Constants.borderColor),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const SearchScreen()),
                    const Divider(color: Constants.borderColor),
                    Expanded(
                        child: ListView.builder(
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title:
                                    Text(projects[index].title ?? "No title"),
                              );
                            }))
                  ],
                ),
              ),
            ),
    );
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
