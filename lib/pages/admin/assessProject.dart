import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/components/button/elevatedButton.dart';
import 'package:tanzify_app/components/snackBar/failedSnackBar.dart';
import 'package:tanzify_app/components/snackBar/snackbar_utils.dart';
import 'package:tanzify_app/components/snackBar/successSnackBar.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/admin/navigation/adminHome.dart';
import 'package:tanzify_app/pages/admin/seeAllProjects.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/profile/rating.dart';
import 'package:tanzify_app/utils/customDialog.dart';
import 'package:timeago/timeago.dart' as timeago;

class AssessProject extends StatefulWidget {
  final String projectId;
  final String title;
  final String projectCreated;
  final String projectDescription;
  final String projectStatus;
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
      required this.freelancer,
      required this.projectStatus});

  @override
  State<AssessProject> createState() => _AssessProjectState();
}

class _AssessProjectState extends State<AssessProject> {
  double? rating;
  String? _dropDownValue;
  final Map<String, dynamic> statusOptions = {
    "Approve": "3",
    "Reject": "4",
    "Return": "3"
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // rating = double.tryParse(widget.freelancer['profile']['rate']);
    final projectProvider = Provider.of<ProjectProvider>(context);

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
                    if (widget.projectStatus != "3")
                      ActionChip(
                        elevation: 2,
                        backgroundColor: Colors.grey[200],
                        label: const Text("Action"),
                        onPressed: () {
                          _showStatusBottomSheet(context, projectProvider);
                        },
                      )
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

  dropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
      });
    }
  }

  void _showStatusBottomSheet(
      BuildContext context, ProjectProvider projectProvider) {
    final Map<String, IconData> statusIcons = {
      "1": Icons.check_circle_outline,
      "2": Icons.cancel_outlined,
      "3": Icons.refresh_outlined,
    };

    final Map<String, Color> statusColor = {
      "1": Colors.green,
      "2": Colors.red,
      "3": Colors.orange
    };

    final Map<String, dynamic> statusMessage = {
      "1": "Are you sure you want to Approve this project?",
      "2": "Are you sure you want to cancel this project?",
      "3": "Returning this project?"
    };

    showModalBottomSheet(
      context: context,
      builder: (context) {
        final statusEntries = statusOptions.entries.toList();

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3, // Adjusted height
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Change Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: statusEntries.length,
                  itemBuilder: (context, index) {
                    final entry = statusEntries[index];
                    final status = entry.key;
                    final value = entry.value;

                    // Determine the icon based on the status value
                    final icon = statusIcons[value] ?? Icons.help_outline;
                    final color = statusColor[value];
                    final message = statusMessage[value] ?? '';
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(status),
                          Icon(icon, color: color),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                        _updateStatus(value, message,
                            projectProvider); // Handle status update
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateStatus(
      String? value, String? message, ProjectProvider projectProvider) {
    print("======value ${value}");

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
              message: '$message',
              onOkPressed: () {
                projectProvider
                    .updateProject(widget.projectId, value.toString())
                    .then((success) async {
                  if (success) {
                    showSnackBar(
                      context,
                      SnackBar(
                        content: Text(projectProvider.successMessage ??
                            'Status updated successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    await projectProvider.getSystemProjects();
                    Navigator.pop(context);
                  } else {
                    showSnackBar(
                      context,
                      SnackBar(
                        content: Text(projectProvider.errorMessage ??
                            'Status updated successfully'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context);
                  }
                });
              },
              onCancelPressed: () {
                Navigator.pop(context);
              },
              type: 1);
        });
  }
}
