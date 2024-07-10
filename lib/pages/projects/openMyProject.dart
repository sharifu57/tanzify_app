import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/components/containers/durationWidget.dart';
import 'package:tanzify_app/components/containers/statusWidget.dart';
import 'package:tanzify_app/components/empty/emptyData.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class OpenMyProject extends StatefulWidget {
  final String projectId;
  const OpenMyProject({super.key, required this.projectId});

  @override
  State<OpenMyProject> createState() => _OpenMyProjectState();
}

class _OpenMyProjectState extends State<OpenMyProject> {
  String? projectId;
  Future<void> fetchProjectBidders() async {
    await Provider.of<ProjectProvider>(context, listen: false)
        .getProjectBidders(
      widget.projectId.toString(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchProjectBidders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final bidders = projectProvider.bidders;
    final isLoading = projectProvider.isLoading;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 14,
              )),
          title: const Center(
            child: Text(
              'Project Bids',
              style: TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 14,
                ))
          ],
        ),
        body: SizedBox(
          child: isLoading
              ? const Center(
                  child: WaveSpinKit(),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Flexible(
                      child: bidders.isEmpty
                          ? const Center(child: EmptyData())
                          : ListView.builder(
                              itemCount: bidders.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Constants.primaryColor,
                                          child: bidders[index]['bidder']
                                                      ['email'] !=
                                                  null
                                              ? Text(
                                                  bidders[index]['bidder']
                                                          ['email'][0]
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              : Text(
                                                  '${(bidders[index]['bidder']['first_name'] ?? '').isNotEmpty ? bidders[index]['bidder']['first_name']![0].toUpperCase() : ''}${(bidders[index]['bidder']['last_name'] ?? '').isNotEmpty ? bidders[index]['bidder']['last_name']![0].toUpperCase() : ''}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 9,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Created: ",
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                          Text(
                                                            timeago.format(DateTime
                                                                .parse(bidders[
                                                                        index][
                                                                    'created'])),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                              width: 8),
                                                          StatusWidget(
                                                              status:
                                                                  "${bidders[index]['status']}")
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5, top: 3),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 7),
                                                          child: Text(
                                                            "${bidders[index]['bidder']['first_name']}",
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Text(
                                                            "${bidders[index]['bidder']['last_name']}",
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  // Text(
                                                  //     "${bidders[index]['proposal']}"),

                                                  ReadMoreText(
                                                    textAlign: TextAlign.start,
                                                    bidders[index]
                                                            ['proposal'] ??
                                                        "",
                                                    trimMode: TrimMode.Line,
                                                    trimLines: 6,
                                                    colorClickableText:
                                                        Colors.pink,
                                                    trimCollapsedText:
                                                        'Show more',
                                                    trimExpandedText:
                                                        'Show less',
                                                    moreStyle: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Constants
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Duration:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      DurationWidget(
                                                          duration:
                                                              "${bidders[index]['duration']}")
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 5.h,
                                                  ),

                                                  Row(
                                                    children: [
                                                      const Text("Amount: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      Text(
                                                          "${bidders[index]['amount']}")
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              })),
                ),
        ));
  }
}
