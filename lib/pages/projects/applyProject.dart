import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/plainInputForm.dart';
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
                  )
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }
}
