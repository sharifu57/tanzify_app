import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tanzify_app/components/appBar/appBar.dart';
import 'package:tanzify_app/pages/constants.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Messages",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                CircleAvatar(
                  backgroundColor: Constants.borderColor,
                  child: Center(
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(LineAwesomeIcons.plus_circle_solid)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
