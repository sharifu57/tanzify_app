import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/profile/rating.dart';
import 'package:timeago/timeago.dart' as timeago;

class AssessProject extends StatefulWidget {
  final String projectId;
  final String title;
  final String projectCreated;
  final String projectDescription;
  final List bids;
  final Map<String, dynamic> budget;
  final Map<String, dynamic> category;
  final List skills;
  final Map<String, dynamic> duration;
  final Map<String, dynamic> freelancer;
  const AssessProject(
      {super.key,
      required this.projectId,
      required this.title,
      required this.projectCreated,
      required this.projectDescription,
      required this.bids,
      required this.budget,
      required this.category,
      required this.skills,
      required this.duration,
      required this.freelancer});

  @override
  State<AssessProject> createState() => _AssessProjectState();
}

class _AssessProjectState extends State<AssessProject> {
  double? rating;

  @override
  Widget build(BuildContext context) {
    print("=======init");
    print(widget.freelancer['profile']?['rate']);
    print("------end init");

    // rating = double.tryParse(widget.freelancer['profile']['rate']);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
        backgroundColor: Constants.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 14,
              color: Colors.white,
            )),
        title: Center(
          child: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.only(right: 20),
              child: const Center(
                child: Icon(
                  Icons.search,
                  color: Constants.accentColor,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 0.h),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(timeago.format(DateTime.parse(widget.projectCreated))),
                    const ActionChip(label: Text('Action'))
                  ],
                ),
              ),
              SizedBox(
                child: Divider(color: Colors.grey[300]),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Project Description",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    SizedBox(
                      child: ReadMoreText(
                        textAlign: TextAlign.justify,
                        widget.projectDescription,
                        trimMode: TrimMode.Line,
                        trimLines: 8,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Price Range",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      "${widget.budget['price_from'] ?? ''} - ${widget.budget['price_to'] ?? ''}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Category",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      "${widget.category['name'] ?? ''}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Duration",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      "${widget.duration['title'] ?? ''}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Skills",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Wrap(
                        runAlignment: WrapAlignment.start,
                        spacing: 4.0,
                        runSpacing: 6.0,
                        children: widget.skills
                            .map((skill) => ChoiceChip(
                                label: Text(skill['name']), selected: true))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Divider(color: Colors.grey[300]),
              ),
              Card(
                child: ListTile(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        backgroundColor: Constants.primaryColor,
                        child: widget.freelancer['email'] != null
                            ? Text(
                                widget.freelancer['email']![0],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            : Text(
                                '${(widget.freelancer['first_name'] ?? '').isNotEmpty ? widget.freelancer['first_name']![0] : ''}${(widget.freelancer['last_name'] ?? '').isNotEmpty ? widget.freelancer['last_name']![0] : ''}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.freelancer['first_name']} ${widget.freelancer['last_name']}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Rating(initialRating: 3.0),
                    ],
                  ),
                  trailing: const SizedBox(
                    width: 70, // Adjust the width as needed
                    child: Center(),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
