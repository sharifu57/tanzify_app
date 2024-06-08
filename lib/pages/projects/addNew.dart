import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/appBar/appBar.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/plainInputForm.dart';
import 'package:tanzify_app/components/form/radioButtonInputForm.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/data/providers/durationProvider.dart';
import 'package:tanzify_app/data/providers/locationProvider.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/models/location/locationModal.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';
import 'package:tanzify_app/pages/constants.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({super.key});

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  String _projectName = "";
  String _description = "";
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _duration = "";
  String _selectedCategory = "";
  List<SkillModel> _skills = [];
  Map<int, bool> _selectedSkills = {};

  String? selectedDurationId;
  String? selectedLocationId;

  String? selectedDuration;
  String? selectedDurationTitle;

  String? selectedLocation;
  String? selectedLocationTitle;

  void handleSelectedItemChange(String? value) {
    setState(() {
      _selectedCategory = value ?? "";
      Provider.of<CategoryProvider>(context, listen: false)
          .getSkillsBycategoryId(_selectedCategory)
          .then((skills) {
        setState(() {
          _skills = skills;
          _selectedSkills = {for (var skill in skills) skill.id: false};
          print("======selectedSkills");
          print(_selectedSkills);
          print("======end selectedSkills");
        });
      });
    });
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
  }

  Future<void> fetchInitialData() async {
    await fetchCategories();
    await fetchDurations();
    await fetchLocations();
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

  bool isStepValid(int step) {
    if (step == 0) {
      return _selectedCategory.isNotEmpty;
    } else if (step == 1) {
      return _selectedSkills.containsValue(true);
    }
    return true; // Step 2 and other steps don't have specific validation in this context
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
          : SizedBox(
              height: fullHeight,
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                            value:
                                                categories[index].id.toString(),
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
                                          return CheckboxListTile(
                                            title: Text(skill.name),
                                            value: _selectedSkills[skill.id],
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _selectedSkills[skill.id] =
                                                    value ?? false;
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
                                        padding: const EdgeInsets.only(top: 5),
                                        child: CustomInputForm(
                                            labelText: "Project Title",
                                            hintText: "Enter project title",
                                            hintStyle:
                                                const TextStyle(fontSize: 11),
                                            controller: projectNameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Project Title is required";
                                              }
                                              return null;
                                            },
                                            onSaved: (value) =>
                                                _projectName = value!,
                                            keyBoardInputType:
                                                TextInputType.name),
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 7.h),
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
                                  content: Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 7.h),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                    ],
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
                                  _submit();
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
                                        backgroundColor: Constants.primaryColor,
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
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Consumer<LocationProvider>(
                    builder: (context, locationProvider, child) {
                      final locations = locationProvider.locations;
                      print("-------here locations ${locations}");
                      if (locations.isEmpty) {
                        return const Center(child: WaveSpinKit());
                      }

                      return ListView(
                        children: locations.map((e) {
                          return RadioListTile<String>(
                            activeColor: Constants.secondaryColor,
                            title: Text(e.name ?? ""),
                            value: e.id.toString(),
                            groupValue: selectedLocation,
                            onChanged: (String? value) {
                              setState(() {
                                selectedLocation = value!;

                                selectedLocationTitle = e.name;
                                print(
                                    "=====location name: ${selectedLocationTitle}");
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
                            print("-===========value duration ${value} =====");
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
