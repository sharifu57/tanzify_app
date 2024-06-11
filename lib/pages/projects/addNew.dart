import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/components/appBar/appBar.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/plainInputForm.dart';
import 'package:tanzify_app/components/form/radioButtonInputForm.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/budgetProvider.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/data/providers/durationProvider.dart';
import 'package:tanzify_app/data/providers/locationProvider.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/models/location/locationModal.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({
    super.key,
  });

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  late final DateTimeFieldPickerPlatform platform;
  String _projectName = "";
  String _description = "";
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _duration = "";
  String? userId;
  String _selectedCategory = "";
  List<SkillModel> _skills = [];
  Map<int, bool> _selectedSkills = {};

  List<int> _selectedSkillIds = [];

  String? selectedDurationId;
  String? selectedLocationId;
  String? selectedBudgetId;

  String? selectedDuration;
  String? selectedDurationTitle;

  String? selectedLocation;
  String? selectedLocationTitle;

  String? selectedBudget;
  String? selectedBudgetTitle;

  DateTime? selectedDate;
  DateTime? selectedTime;
  DateTime? selectedDateTime;

  void handleSelectedItemChange(String? value) {
    setState(() {
      _selectedCategory = value ?? "";
      Provider.of<CategoryProvider>(context, listen: false)
          .getSkillsBycategoryId(_selectedCategory)
          .then((skills) {
        setState(() {
          _skills = skills;
          _selectedSkills = {for (var skill in skills) skill.id: false};
        });
      });
    });
  }

  void getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      final userData = jsonDecode(user);
      setState(() {
        userId = userData["id"].toString();
      });
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      print('Form submitted');
      // Handle form submission
    }
  }

  @override
  void initState() {
    super.initState();
    fetchInitialData();
    getUserFromStorage();
  }

  Future<void> fetchInitialData() async {
    await fetchCategories();
    await fetchDurations();
    await fetchLocations();
    await fetchBudgets();
  }

  Future<void> fetchCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false).getCategories();
  }

  Future<void> fetchDurations() async {
    await Provider.of<DurationProvider>(context, listen: false).getDurations();
  }

  Future<void> fetchLocations() async {
    await Provider.of<LocationProvider>(context, listen: false).getLocations();
  }

  Future<void> fetchBudgets() async {
    await Provider.of<BudgetProvider>(context, listen: false).getBudgets();
  }

  bool isStepValid(int step) {
    if (step == 0) {
      return _selectedCategory.isNotEmpty;
    } else if (step == 1) {
      // containsValue is used for Map and not list
      return _selectedSkillIds.isNotEmpty;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categoryList;

    final isLoading = projectProvider.isLoading;
    final double fullHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);

    String? validateProjectName(String? phoneNumber) {
      if (phoneNumber == null || phoneNumber.isEmpty) {
        return "Phone number cannot be empty";
      }
      // Regex pattern to match Tanzanian phone numbers
      String pattern = r'^(\+255)\d{9}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(phoneNumber)) {
        return "Enter a valid phone number starting with +255";
      }
      return null;
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const WaveSpinKit()
          : SingleChildScrollView(
              child: SizedBox(
                // height: fullHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text(
                                "Upload new Project",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              child: TextButton.icon(
                                label: const Text("Cancel"),
                                icon: const Icon(
                                  Icons.cancel,
                                  size: 12,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          child: Form(
                            key: _formKey,
                            child: Stepper(
                              steps: [
                                Step(
                                  isActive: _currentStep == 0,
                                  title: const Text("Select Category"),
                                  content: Container(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      height: fullHeight / 4,
                                      child: ListView.builder(
                                        itemCount: categories.isEmpty
                                            ? 0
                                            : categories.length,
                                        itemBuilder: (context, index) {
                                          return RadioButtonFormInput(
                                              onSelectedItemChanged:
                                                  handleSelectedItemChange,
                                              title: categories[index].name,
                                              value: categories[index]
                                                  .id
                                                  .toString(),
                                              groupValue: _selectedCategory,
                                              onSaved: (value) {
                                                _selectedCategory = value!;
                                              });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Step(
                                  isActive: _currentStep == 1,
                                  title: const Text("Select Skills"),
                                  content: _skills.isNotEmpty
                                      ? Column(
                                          children: _skills.map((skill) {
                                            // return CheckboxListTile(
                                            //   title: Text(skill.name),
                                            //   value: _selectedSkills[skill.id],
                                            //   onChanged: (bool? value) {
                                            //     setState(() {
                                            //       _selectedSkills[skill.id] =
                                            //           value ?? false;
                                            //     });
                                            //   },
                                            // );

                                            return CheckboxListTile(
                                              title: Text(skill.name),
                                              value: _selectedSkillIds
                                                  .contains(skill.id),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (value ?? false) {
                                                    _selectedSkillIds
                                                        .add(skill.id);
                                                  } else {
                                                    _selectedSkillIds
                                                        .remove(skill.id);
                                                  }
                                                });
                                              },
                                            );
                                          }).toList(),
                                        )
                                      : const Text(
                                          "No skills available for this category."),
                                ),
                                Step(
                                    isActive: _currentStep == 2,
                                    title: const Text("Describe Project"),
                                    content: Column(
                                      children: [
                                        Container(
                                          // height: 10.h,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: CustomInputForm(
                                            labelText: "Project Title",
                                            hintText: "Enter project title",
                                            hintStyle:
                                                const TextStyle(fontSize: 11),
                                            controller: projectNameController,
                                            keyBoardInputType:
                                                TextInputType.name,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Project Title is required";
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _projectName = value!;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        PlainInputForm(
                                          maxLines: "5",
                                          hintText: 'Project Description',
                                          controller:
                                              projectDescriptionController,
                                          keyBoardInputType: TextInputType.text,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Please enter a valid description";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _description = value ?? '';
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 7.h),
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                              "How long will this Project Take?"),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showDurationBottomSheet(context);
                                          },
                                          child: Card.outlined(
                                            elevation: 0,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 13,
                                                        horizontal: 15),
                                                child: selectedDuration == null
                                                    ? const Text(
                                                        "Select Duration")
                                                    : Text(
                                                        "$selectedDurationTitle"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Step(
                                    isActive: _currentStep == 3,
                                    title: const Text("Other Details"),
                                    content: SizedBox(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0.h),
                                            alignment: Alignment.centerLeft,
                                            child: const Text("Location"),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showLocationBottomSheet(context);
                                            },
                                            child: Card.outlined(
                                              elevation: 0,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 13,
                                                      horizontal: 15),
                                                  child: selectedLocationTitle ==
                                                          null
                                                      ? const Text(
                                                          "Select Location")
                                                      : Text(
                                                          "$selectedLocationTitle"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7.h),
                                            alignment: Alignment.centerLeft,
                                            child: const Text("Budget"),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showBudgetBottomSheet(context);
                                            },
                                            child: Card.outlined(
                                              elevation: 0,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 13,
                                                      horizontal: 15),
                                                  child: selectedBudgetTitle ==
                                                          null
                                                      ? const Text(
                                                          "Select Budget")
                                                      : Text(
                                                          "$selectedBudgetTitle"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7.h),
                                            alignment: Alignment.centerLeft,
                                            child: const Text("Deadline"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: DateTimeField(
                                              decoration: InputDecoration(
                                                labelText: 'Deadline',
                                                helperText: 'YYYY/MM/DD',
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 15),
                                              ),
                                              value: selectedDate,
                                              dateFormat: DateFormat.yMd(),
                                              mode:
                                                  DateTimeFieldPickerMode.date,
                                              // pickerPlatform: widget.platform,
                                              onChanged: (DateTime? value) {
                                                setState(() {
                                                  selectedDate = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                              onStepTapped: (int newIndex) {
                                setState(() {
                                  _currentStep = newIndex;
                                });
                              },
                              currentStep: _currentStep,
                              onStepContinue: () {
                                if (isStepValid(_currentStep)) {
                                  if (_currentStep < 3) {
                                    setState(() {
                                      _currentStep += 1;
                                    });
                                  } else {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      print("======saved current state");

                                      var postPayload = {
                                        "created_by": userId,
                                        "title":
                                            projectNameController.text.trim(),
                                        "description": _description,
                                        "category": _selectedCategory,
                                        "skills": _selectedSkillIds,
                                        "duration": selectedDuration,
                                        "location": selectedLocationId,
                                        "budget": selectedBudgetId,
                                        "deadline": selectedDate.toString(),
                                      };

                                      print("=======my payload ${postPayload}");
                                      projectProvider
                                          .createProject(postPayload)
                                          .then((success) => {
                                                if (success)
                                                  {
                                                    AlertDialog(
                                                      title: Text(
                                                          "Project Created"),
                                                      content: Text(
                                                          "Your project has been created"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text("OK"),
                                                        ),
                                                      ],
                                                    )
                                                  }
                                                else
                                                  {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            content: Text(
                                                                projectProvider
                                                                    .errorMessage)))
                                                  }
                                              });
                                    }
                                  }
                                }
                              },
                              onStepCancel: () {
                                if (_currentStep != 0) {
                                  setState(() {
                                    _currentStep -= 1;
                                  });
                                }
                              },
                              type: StepperType.vertical,
                              controlsBuilder: (BuildContext context,
                                  ControlsDetails details) {
                                final isLastStep = _currentStep == 3;
                                final isStepValid =
                                    this.isStepValid(_currentStep);

                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: isStepValid
                                            ? details.onStepContinue
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Constants.primaryColor,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                        ),
                                        child: Text(
                                          isLastStep ? 'Submit' : 'Continue',
                                          style: const TextStyle(
                                              color: Constants.fillColor),
                                        ),
                                      ),
                                      if (_currentStep != 0)
                                        TextButton(
                                          onPressed: details.onStepCancel,
                                          child: const Text('Back'),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void _showBudgetBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Select Budget',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Consumer<BudgetProvider>(
                      builder: (context, budgetProvider, child) {
                        final budgets = budgetProvider.budgets;
                        if (budgets.isEmpty) {
                          return const Center(child: WaveSpinKit());
                        }

                        return ListView(
                          children: budgets.map((e) {
                            return RadioListTile<String>(
                              activeColor: Constants.primaryColor,
                              title: Row(
                                children: [
                                  Text(e.price_from ?? ""),
                                  const Text(" - "),
                                  Text(e.price_to ?? ""),
                                ],
                              ),
                              value: e.id.toString(),
                              groupValue: selectedBudget,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedBudget = value!;
                                  selectedBudgetId = value;
                                  final newTitle =
                                      "${e.price_from} - ${e.price_to}";
                                  selectedBudgetTitle = newTitle;
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
            ),
          );
        });
  }

  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Select Location',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Consumer<LocationProvider>(
                      builder: (context, locationProvider, child) {
                        final locations = locationProvider.locations;
                        if (locations.isEmpty) {
                          return const Center(child: WaveSpinKit());
                        }

                        return ListView(
                          children: locations.map((e) {
                            return RadioListTile<String>(
                              activeColor: Constants.primaryColor,
                              title: Text(e.name ?? ""),
                              value: e.id.toString(),
                              groupValue: selectedLocation,
                              onChanged: (String? value) {
                                setState(() {
                                  print("=====selectde location: ${value}");
                                  selectedLocation = value!;
                                  selectedLocationId = value.toString();
                                  selectedLocationTitle = e.name;
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
            ),
          );
        });
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
                      return const Center(child: WaveSpinKit());
                    }

                    return ListView(
                      children: durations.map((e) {
                        return RadioListTile<String>(
                          activeColor: Constants.secondaryColor,
                          title: Text(e.title),
                          value: e.id.toString(),
                          groupValue: selectedDuration,
                          onChanged: (String? value) {
                            setState(() {
                              selectedDuration = value!;
                              selectedDurationTitle = e.title;
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
