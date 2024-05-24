import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/plainInputForm.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/durationProvider.dart';
import 'package:tanzify_app/pages/constants.dart';

class ApplyProject extends StatefulWidget {
  int? projectId;
  String? projectTitle;
  String? projectDescription;
  String? projectBudget;

  ApplyProject(
      {super.key,
      required this.projectId,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectBudget});

  @override
  State<ApplyProject> createState() => _ApplyProjectState();
}

class _ApplyProjectState extends State<ApplyProject> {
  late TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedDuration;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
      Provider.of<DurationProvider>(context, listen: false).getDurations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
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
                widget.projectTitle ?? '',
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Submit your Proposal",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ReadMoreText(
                    textAlign: TextAlign.start,
                    widget.projectDescription ?? "",
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Constants.primaryColor),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  child: _buildForm(),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildForm() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text(
            "Terms",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Bid",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                        "Total amount the client will see on your proposal"),
                  ),
                  PlainInputForm(
                    hintText: '${widget.projectBudget}',
                    controller: textController,
                    // prefixAmount: '2000',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter a valid amount";
                      }
                      return null;
                    },
                    onSaved: null,
                  ),
                  SizedBox(height: 20.h),
                  // PlainInputForm(
                  //   controller: textController,
                  //   hintText: "$selectedDuration",
                  //   validator: validator,
                  //   onSaved: onSaved,
                  // )
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _showDurationBottomSheet(context);
                  //   },
                  //   child: const Text('Select Duration'),
                  // ),
                  // Card.outlined(
                  //     elevation: 2,
                  //     shape: const RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(10),
                  //           child: GestureDetector(
                  //             onTap: () {},
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    alignment: Alignment.centerLeft,
                    child: const Text("How long will this Project Take?"),
                  ),

                  GestureDetector(
                    onTap: () {
                      _showDurationBottomSheet(context);
                    },
                    child: Card.outlined(
                      elevation: 0,
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 15),
                          child: selectedDuration == null
                              ? const Text("Selected Duration")
                              : Text("$selectedDuration"),
                        ),
                      ),
                    ),
                  ),
                  // if (selectedDuration != null)
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //     child: Text(
                  //       'Selected Duration: $selectedDuration',
                  //       style: const TextStyle(
                  //           fontSize: 16, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

  void _showDurationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.45, // 40% of screen height
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Duration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Consumer<DurationProvider>(
                  builder: (context, durationProvider, child) {
                    final durations = durationProvider.durations;

                    if (durations.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                      children: durations.map((e) {
                        return RadioListTile<String>(
                          activeColor: Constants.secondaryColor,
                          title: Text(e.title),
                          // value: e.id.toString(),
                          value: e.title,
                          groupValue: selectedDuration,
                          onChanged: (String? value) {
                            setState(() {
                              selectedDuration = value;
                            });
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
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
}
