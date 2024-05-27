import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/pages/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? firstName;
  String? lastName;
  String? profileImage;
  String? email;

  @override
  void initState() {
    getUserFromStorage();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      automaticallyImplyLeading: false,
      leading: Container(
        padding: const EdgeInsets.only(left: 17),
        child: Container(
          width: 10,
          height: 10,
          padding: const EdgeInsets.all(1),
          child: profileImage != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(profileImage!),
                )
              : CircleAvatar(
                  backgroundColor: Constants.primaryColor,
                  child: email != null
                      ? Text(
                          email![0],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        )
                      : Text(
                          '${(firstName ?? '').isNotEmpty ? firstName![0] : ''}${(lastName ?? '').isNotEmpty ? lastName![0] : ''}',
                          style: const TextStyle(color: Colors.white),
                        ),
                ),
        ),
      ),
    );
  }
}
