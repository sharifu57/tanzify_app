import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/pages/constants.dart';

class ImageProfile extends StatefulWidget {
  const ImageProfile({super.key});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  String? firstName;
  String? lastName;
  String? profileImage;
  String? email;
  String? categoryName;
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
          categoryName = userData['profile']['category']['name'];
          email = userData["email"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            // child: const Image(image: AssetImage(tProfileImage))

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
                                color: Colors.white, fontSize: 30),
                          )
                        : Text(
                            '${(firstName ?? '').isNotEmpty ? firstName![0] : ''}${(lastName ?? '').isNotEmpty ? lastName![0] : ''}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Constants.secondaryColor),
            child: Center(
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    LineAwesomeIcons.edit,
                    size: 15,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
