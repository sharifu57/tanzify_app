import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/appBar/appBar.dart';
import 'package:tanzify_app/components/form/radioButtonInputForm.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';
import 'package:tanzify_app/models/skill/skillModal.dart';
import 'package:tanzify_app/pages/constants.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({super.key});

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _selectedCategory = "";
  List<SkillModel> _skills = [];
  Map<int, bool> _selectedSkills = {};

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

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      print('Form submitted');
      // Handle form submission
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false).getCategories();
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
                      const SizedBox(height: 10),
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
                                content: const Text("Details for step 2"),
                              ),
                            ],
                            onStepTapped: (int newIndex) {
                              setState(() {
                                _currentStep = newIndex;
                              });
                            },
                            currentStep: _currentStep,
                            onStepContinue: () {
                              if (isStepValid(_currentStep)) {
                                if (_currentStep < 2) {
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
                              final isLastStep = _currentStep == 2;
                              final isStepValid =
                                  this.isStepValid(_currentStep);

                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
}
