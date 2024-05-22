import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/models/project/projectModal.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

class ViewProject extends StatefulWidget {
  final ProjectModel project;
  const ViewProject({super.key, required this.project});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    final double fullWidth = MediaQuery.of(context).size.width;
    final projectProvider = Provider.of<ProjectProvider>(context);
    final isLoading = projectProvider.isLoading;
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);

    String formatDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) {
        return "Date not available";
      }
      try {
        DateTime date = DateTime.parse(dateStr);
        return DateFormat('MMMM dd, yyyy').format(date);
      } catch (e) {
        return 'Invalid date format';
      }
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
          title: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.project.title ?? "Project Details",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 40),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: WaveSpinKit(),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              const Text(
                                "Posted ",
                                style: TextStyle(fontSize: 11),
                              ),
                              Text(
                                widget.project.created != null
                                    ? timeago.format(
                                        DateTime.parse(widget.project.created!))
                                    : "Date not available",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Icon(
                                  Icons.share_location_sharp,
                                  size: 20,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              Text("${widget.project.location?.name}"),
                            ],
                          ),
                        ),
                        SizedBox(
                            child: Text(
                                "${widget.project.bids?.length ?? 0} Connected proposals")),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider()),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(right: 5),
                                alignment: Alignment.topLeft,
                                child: const Icon(
                                  Icons.campaign_rounded,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: ReadMoreText(
                                  textAlign: TextAlign.start,
                                  widget.project.description ?? "",
                                  trimMode: TrimMode.Line,
                                  trimLines: 7,
                                  colorClickableText: Colors.pink,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  moreStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Constants.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider()),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.price_check_outlined),
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                    "${widget.project.budget?.price_from} - ${widget.project.budget?.price_to}"),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.workspace_premium_outlined),
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                child:
                                    Text("${widget.project.experience?.title}"),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider()),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  "Skills Required",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  runAlignment: WrapAlignment.start,
                                  spacing: 4.0,
                                  runSpacing: 6.0,
                                  children: widget.project.skills!
                                      .map((skill) => ChoiceChip(
                                          label: Text(skill.name),
                                          selected: true))
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider()),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  "About the Client",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.verified_rounded,
                                      color: Constants.primaryColor,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child:
                                          const Text("Phone Number Verified"),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                // padding:
                                //     const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    // const Icon(
                                    //   Icons.verified_rounded,
                                    //   color: Constants.primaryColor,
                                    // ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          const Text("Member Since: "),
                                          // Text(widget.project.created_by
                                          //         ?.date_joined ??
                                          //     '')
                                          Text(formatDate(widget
                                              .project.created_by?.date_joined))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            height: 80), // Spacer for button at bottom
                      ],
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          elevation: 8.0,
          color: Colors.white,
          height: 60,
          child: Container(
            // color: Colors.white,
            // padding:
            //     const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: SizedBox(
              // width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: fullWidth / 2.3,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor, // Button color
                        // padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Apply Now",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: fullWidth / 2.3,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor, // Button color
                        // padding: const EdgeInsets.symmetric(vertical: 10),

                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Share Job",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // FormButton(
                  //     variant: FormButtonVariant.filled,
                  //     onClick: () {},
                  //     text: "Apply Now")
                ],
              ),
            ),
          ),
        ));
  }
}
