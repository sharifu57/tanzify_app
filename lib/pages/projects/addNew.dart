import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/appBar/appBar.dart';
import 'package:tanzify_app/components/form/radioButtonInputForm.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({super.key});

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _selectedCategory = "1";

  void handleSelectedItemChange(String? value) {
    print("======value");
    print(value);
    print("===end value");

    setState(() {
      _selectedCategory = value ?? "";
      Provider.of<CategoryProvider>(context, listen: false)
          .getSkillsBycategoryId(_selectedCategory);
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Submit the form
      print('Form submitted');
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
                        // height: fullHeight - 100,
                        child: Form(
                          key: _formKey,
                          child: Stepper(
                            steps: [
                              Step(
                                isActive: _currentStep == 0,
                                title: const Text("Step 0"),
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
                                              print("=======value");
                                              print(value);
                                              print("=====end value");

                                              _selectedCategory = value!;
                                              print("=====selected Category: " +
                                                  _selectedCategory);
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Step(
                                isActive: _currentStep == 1,
                                title: const Text("Step 1"),
                                content: const Text("Details for step 1"),
                              ),
                              Step(
                                isActive: _currentStep == 2,
                                title: const Text("Step 2"),
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
                              if (_currentStep != 2) {
                                setState(() {
                                  _currentStep += 1;
                                });
                              } else {
                                _submit();
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
                              return Row(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: details.onStepContinue,
                                    child: Text(
                                        isLastStep ? 'Submit' : 'Continue'),
                                  ),
                                  if (_currentStep != 0)
                                    TextButton(
                                      onPressed: details.onStepCancel,
                                      child: const Text('Back'),
                                    ),
                                ],
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
