import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/components/containers/statusWidget.dart';
import 'package:tanzify_app/components/icons/simpleIcon.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppliedBid extends StatefulWidget {
  const AppliedBid({super.key});

  @override
  State<AppliedBid> createState() => _AppliedBidState();
}

class _AppliedBidState extends State<AppliedBid> {
  int? userId;
  String? userIdString;

  @override
  void initState() {
    super.initState();
    getUserFromStorage();
  }

  Future<void> fetchMyBids() async {
    if (userId != null) {
      await Provider.of<ProjectProvider>(context, listen: false)
          .getMyBids(userId!);
    }
  }

  void getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      final userData = jsonDecode(user);
      final dynamic userIdData = userData["id"];

      if (userIdData != null) {
        setState(() {
          userId = int.tryParse(userIdData.toString());
          userIdString = userId != null ? userId.toString() : '';
        });

        fetchMyBids();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final bids = projectProvider.myBids;

    final isLoading = projectProvider.isLoading;
    return Scaffold(
        body: SizedBox(
      child: isLoading
          ? const Center(
              child: WaveSpinKit(),
            )
          : RefreshIndicator(
              onRefresh: _handleRefresh,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Flexible(
                    child: bids.isNotEmpty
                        ? ListView.builder(
                            itemCount: bids.isEmpty ? 0 : bids.length,
                            itemBuilder: (context, index) {
                              final bid = bids[index] as Map<String, dynamic>;
                              final project =
                                  bid['project'] as Map<String, dynamic>?;
                              return Card(
                                elevation: 0.4,
                                shadowColor: Constants.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Bid Sent",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              Text(
                                                timeago.format(DateTime.parse(
                                                    bid['created'])),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // const SimpleIcon(
                                              //     size: 11,
                                              //     color: Constants.successColor,
                                              //     icon: Icons
                                              //         .verified_user_outlined),
                                              const SizedBox(width: 8),
                                              StatusWidget(
                                                  status: "${bid['status']}")
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          project!['title'] ?? '',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: SizedBox(
                                            child: ReadMoreText(
                                          textAlign: TextAlign.start,
                                          project["description"] ?? "",
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
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Center(
                            child: Lottie.asset(
                              'assets/img/empty.json',
                              repeat: true,
                              fit: BoxFit.contain,
                            ),
                          )),
              )),
    ));
    // return
  }

  Future<void> _handleRefresh() async {
    try {
      await fetchMyBids();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to refresh: $error'),
        ),
      );
    }
  }
}
