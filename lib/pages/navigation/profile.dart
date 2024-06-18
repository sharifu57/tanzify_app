import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/components/profile/imageProfile.dart';
import 'package:tanzify_app/components/profile/profileWidget.dart';
import 'package:tanzify_app/components/profile/updateProfile.dart';
import 'package:tanzify_app/pages/constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          leading: IconButton(
              onPressed: () {}, icon: const Icon(LineAwesomeIcons.moon)),
          title: const Text(
            "",
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon:
                    Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ImageProfile(),
              const SizedBox(height: 10),
              Text("$firstName $lastName",
                  style: Theme.of(context).textTheme.headlineSmall),
              Text("$categoryName",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              SizedBox(
                // width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => const UpdateProfileScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.tertiaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("Edit Profile",
                      style: TextStyle(color: Constants.fillColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Settings",
                  icon: LineAwesomeIcons.cog_solid,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Billing Details",
                  icon: LineAwesomeIcons.wallet_solid,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "User Management",
                  icon: LineAwesomeIcons.user_check_solid,
                  onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information",
                  icon: LineAwesomeIcons.info_solid,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.sign_out_alt_solid,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    // Get.defaultDialog(
                    //   title: "LOGOUT",
                    //   titleStyle: const TextStyle(fontSize: 20),
                    //   content: const Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 15.0),
                    //     child: Text("Are you sure, you want to Logout?"),
                    //   ),
                    //   confirm: Expanded(
                    //     child: ElevatedButton(
                    //       onPressed: () =>
                    //           AuthenticationRepository.instance.logout(),
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.redAccent,
                    //           side: BorderSide.none),
                    //       child: const Text("Yes"),
                    //     ),
                    //   ),
                    //   cancel: OutlinedButton(
                    //       onPressed: () => Get.back(), child: const Text("No")),
                    // );
                  }),
            ],
          ),
        )));
  }
}
