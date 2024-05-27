import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';

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
    final bids = projectProvider.bidsList;
    final isLoading = projectProvider.isLoading;
    return Container(
      child: isLoading
          ? const Center(
              child: WaveSpinKit(),
            )
          : RefreshIndicator(
              onRefresh: _handleRefresh,
              child: Flexible(
                  child: ListView.builder(
                      itemCount: bids.isEmpty ? 0 : bids.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Text("One"),
                        );
                      }))),
    );
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
