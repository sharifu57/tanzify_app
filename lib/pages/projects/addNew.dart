import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/appBar/appBar.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/projectProvider.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({super.key});

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final isLoading = projectProvider.isLoading;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const WaveSpinKit()
          : Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Stepper(
                      steps: [
                        Step(
                            isActive: _currentStep == 0,
                            title: const Text("Step 0"),
                            content: const Text("Details for step 0")),
                        Step(
                            isActive: _currentStep == 1,
                            title: const Text("Step 1"),
                            content: const Text("Details for step 1")),
                        Step(
                            isActive: _currentStep == 2,
                            title: const Text("Step 2"),
                            content: const Text("Details for step 2"))
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
                        }
                      },
                      onStepCancel: () {
                        if (_currentStep != 0) {
                          setState(() {
                            _currentStep -= 1;
                          });
                        }
                      },
                      // type: StepperType.horizontal,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
