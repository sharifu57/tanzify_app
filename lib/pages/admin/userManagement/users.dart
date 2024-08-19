import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tanzify_app/components/containers/statusWidget.dart';
import 'package:tanzify_app/data/providers/userProvider.dart';
import 'package:tanzify_app/pages/constants.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  String? firstName;
  String? lastName;
  String? profileImage;
  String? email;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserFromStorage();
      getUsers();
    });
  }

  void getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      final userData = jsonDecode(user);
      final dynamic userIdData = userData["id"];

      if (userIdData != null) {
        setState(() {
          firstName = userData["first_name"];
          lastName = userData["last_name"];
          profileImage = userData['profile']['profile_image'];
          email = userData["email"];
        });
      }
    }
  }

  Future<void> getUsers() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).getUsers();
    } catch (e) {
      debugPrint("error getting users: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Change listen to true to rebuild the widget when the loading state changes
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final users = userProvider.sysUsers;

    if (users.isEmpty) {
      return Center(
        child: Text("No users found"),
      );
    }
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add_circle)),
                    const Text("Contacts"),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(1),
                        child: profileImage != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(profileImage!),
                              )
                            : CircleAvatar(
                                backgroundColor: Constants.primaryColor,
                                child: email != null
                                    ? Text(
                                        email![0].toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    : Text(
                                        '${(firstName ?? '').isNotEmpty ? firstName![0].toUpperCase() : ''}${(lastName ?? '').isNotEmpty ? lastName![0].toUpperCase() : ''}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20, child: Text("search Bar")),
              SizedBox(
                  child: Skeletonizer(
                enabled: userProvider.isLoading,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.isEmpty ? 0 : users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Card(
                            elevation: 3,
                            child: InkWell(
                              splashColor: Constants.primaryColor,
                              onTap: () {},
                              child: ListTile(
                                leading: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons.wolf_pack_battalion,
                                    color: Constants.primaryColor,
                                    size: 18,
                                  ),
                                ),
                                title: const Text("One"),
                                trailing: const SizedBox(
                                  width: 70, // Adjust the width as needed
                                  child: Center(
                                    child: StatusWidget(status: "One"),
                                  ),
                                ),
                              ),
                            )),
                      );
                    }),
              )),
            ],
          ),
        ),
      )),
    );
  }
}
