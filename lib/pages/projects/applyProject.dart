import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/form/plainInputForm.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/durationProvider.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/pages/constants.dart';

class ApplyProject extends StatefulWidget {
  final int? projectId;
  final String? projectTitle;
  final String? projectDescription;
  final String? projectBudget;

  ApplyProject({
    super.key,
    required this.projectId,
    required this.projectTitle,
    required this.projectDescription,
    required this.projectBudget,
  });

  @override
  State<ApplyProject> createState() => _ApplyProjectState();
}

class _ApplyProjectState extends State<ApplyProject> {
  late TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedDuration;
  PlatformFile? selectedFile;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
      Provider.of<DurationProvider>(context, listen: false).getDurations();
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  _removeFile() {
    setState(() {
      selectedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    final projectProvider = Provider.of<ProjectProvider>(context);
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                child: _buildForm(projectProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    ProjectProvider projectProvider,
  ) {
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
                    maxLines: "1",
                    hintText: '${widget.projectBudget}',
                    controller: textController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter a valid amount";
                      }
                      return null;
                    },
                    onSaved: null,
                  ),
                  SizedBox(height: 20.h),
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
                              ? const Text("Select Duration")
                              : Text("$selectedDuration"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                        "Describe your recent experience with similar projects"),
                  ),
                  PlainInputForm(
                    maxLines: "5",
                    hintText: '',
                    controller: textController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter a valid description";
                      }
                      return null;
                    },
                    onSaved: null,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    alignment: Alignment.centerLeft,
                    child: const Text("Attachment in PDF (if any)"),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card.outlined(
                      elevation: 0,
                      child: Container(
                          width: double.infinity,
                          color: Constants.fillColor,
                          child: Container(
                            child: selectedFile == null
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                        onTap: _pickFile,
                                        child: const Text("Select a PDF file")),
                                  )
                                : Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 9,
                                            child: Text(selectedFile!.name)),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              onPressed: () {
                                                _removeFile();
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                size: 19,
                                                color: Colors.red,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                          )),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  projectProvider.isLoading
                      ? const WaveSpinKit()
                      : FormButton(
                          fullWidth: true,
                          text: "Submit",
                          variant: FormButtonVariant.filled,
                          onClick: () {
                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            //   authProvider
                            //       .login(emailController.text,
                            //           passwordController.text)
                            //       .then((success) {
                            //     if (!success) {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(
                            //             backgroundColor: Colors.red,
                            //             content:
                            //                 Text(authProvider.errorMessage)),
                            //       );
                            //     } else {
                            //       Navigator.of(context).push(CupertinoPageRoute(
                            //           builder: (context) => const MainApp()));
                            //     }
                            //   });
                            // }
                          }),
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
              MediaQuery.of(context).size.height * 0.45, // 45% of screen height
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
