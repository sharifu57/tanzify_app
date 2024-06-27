import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/selectInputForm.dart';
import 'package:tanzify_app/components/profile/imageProfile.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';
import 'package:tanzify_app/pages/authentication/verification.dart';
import 'package:tanzify_app/pages/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  final String _lastName = "";
  String _email = "";
  final String _password = "";
  String _phoneNumber = "";
  String _category = "";

  CategoryModel? selectedCategory;
  String _selectedItem = "1";

  void handleSelectedItemChange(String? value) {
    setState(() {
      _selectedItem = value ?? "1"; // Assuming "1" is a safe default
    });
  }

  String? firstName;
  String? lastName;
  String? profileImage;
  String? email;
  String? phoneNumber;
  String? categoryName;

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
          phoneNumber = userData['profile']['phone_number'];
          email = userData["email"];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserFromStorage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getCategories();
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categoryList;
    final isLoading = categoryProvider.isLoading;
    final errorMessage = categoryProvider.errorMessage;
    final fullHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    final double fullHeigth = MediaQuery.of(context).size.height;

    if (categories.isNotEmpty && selectedCategory == null) {
      selectedCategory = categories[0];
    }

    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left_solid,
              size: 15,
            )),
        title: const Center(
          child: Text(
            "Update Profile",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.only(right: 50), child: const Text(""))
        ],
        // Text("Profile", style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: fullHeigth,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: ImageProfile(),
              ),
              SizedBox(height: 50.h),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputForm(
                          labelText: "First Name",
                          hintText: "$firstName",
                          hintStyle: TextStyle(
                              color: Constants.primaryColor, fontSize: 10.sp),
                          controller: firstNameController,
                          keyBoardInputType: TextInputType.text,
                          obscureText: false,
                          icon: LineAwesomeIcons.user_alt_solid,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "First name is required";
                            }
                            return null;
                          },
                          onSaved: (value) => _firstName = value!,
                        ),
                        SizedBox(height: 20.h),
                        CustomInputForm(
                          labelText: "Last Name",
                          hintText: "$lastName",
                          hintStyle: TextStyle(
                              color: Constants.primaryColor, fontSize: 10.sp),
                          controller: firstNameController,
                          keyBoardInputType: TextInputType.text,
                          obscureText: false,
                          icon: LineAwesomeIcons.user_circle,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Last name is required";
                            }
                            return null;
                          },
                          onSaved: (value) => _firstName = value!,
                        ),
                        SizedBox(height: 20.h),
                        CustomInputForm(
                          labelText: "Email",
                          hintText: "$email",
                          hintStyle: TextStyle(
                              color: Constants.primaryColor, fontSize: 10.sp),
                          controller: emailController,
                          keyBoardInputType: TextInputType.emailAddress,
                          obscureText: false,
                          icon: LineAwesomeIcons.envelope,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return "Email enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value!,
                        ),
                        SizedBox(height: 20.h),
                        CustomInputForm(
                          labelText: "Phone",
                          hintText: "$phoneNumber",
                          hintStyle: TextStyle(
                              color: Constants.primaryColor, fontSize: 10.sp),
                          controller: phoneNumberController,
                          keyBoardInputType: TextInputType.phone,
                          obscureText: false,
                          icon: LineAwesomeIcons.mobile_alt_solid,
                          validator: validatePhoneNumber,
                          onSaved: (value) => _phoneNumber = value!,
                        ),
                        SizedBox(height: 20.h),
                        if (categories.isNotEmpty)
                          CustomSelectForm(
                            categories: categories.map((e) => e.name).toList(),
                            selectedCategory: selectedCategory!.name ?? "null",
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = categories
                                    .firstWhere((cat) => cat.name == newValue);
                                _category = selectedCategory!.id.toString();
                              });
                            },
                            onSaved: (value) => _category = value!,
                          ),
                        SizedBox(height: 20.h),
                        _submitButton(authProvider),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),

      // body: SingleChildScrollView(
      //   child: Container(
      //     height: fullHeigth,
      //     padding: const EdgeInsets.all(20),
      //     child: Column(
      //       children: [
      //         const ImageProfile(),
      //         const SizedBox(height: 50),
      //         SizedBox(
      //           child: Form(
      //               key: _formKey,
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     child: CustomInputForm(
      //                       labelText: "First Name",
      //                       hintText: "Enter your first name",
      //                       hintStyle: TextStyle(
      //                           color: Constants.primaryColor, fontSize: 10.sp),
      //                       controller: firstNameController,
      //                       keyBoardInputType: TextInputType.text,
      //                       obscureText: false,
      //                       validator: (value) {
      //                         if (value!.isEmpty) {
      //                           return "First name is required";
      //                         }
      //                         return null;
      //                       },
      //                       onSaved: (value) => _firstName = value!,
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: CustomInputForm(
      //                       labelText: "Last Name",
      //                       hintText: "Enter your last name",
      //                       hintStyle: TextStyle(
      //                           color: Constants.primaryColor, fontSize: 10.sp),
      //                       controller: lastNameController,
      //                       keyBoardInputType: TextInputType.text,
      //                       obscureText: false,
      //                       validator: (value) {
      //                         if (value!.isEmpty) {
      //                           return "Last name is required";
      //                         }
      //                         return null;
      //                       },
      //                       onSaved: (value) => _lastName = value!,
      //                     ),
      //                   ),
      //                   SizedBox(height: 30.h),
      //                   CustomInputForm(
      //                     labelText: "Email",
      //                     hintText: "",
      //                     hintStyle: TextStyle(
      //                         color: Constants.primaryColor, fontSize: 10.sp),
      //                     controller: emailController,
      //                     keyBoardInputType: TextInputType.emailAddress,
      //                     obscureText: false,
      //                     validator: (value) {
      //                       if (value!.isEmpty || !value.contains('@')) {
      //                         return "Email enter a valid email address";
      //                       }
      //                       return null;
      //                     },
      //                     onSaved: (value) => _email = value!,
      //                   ),
      //                   SizedBox(height: 30.h),
      //                   CustomInputForm(
      //                     labelText: "Phone",
      //                     hintText: "",
      //                     hintStyle: TextStyle(
      //                         color: Constants.primaryColor, fontSize: 10.sp),
      //                     controller: phoneNumberController,
      //                     keyBoardInputType: TextInputType.phone,
      //                     obscureText: false,
      //                     validator: validatePhoneNumber,
      //                     onSaved: (value) => _phoneNumber = value!,
      //                   ),
      //                   SizedBox(height: 30.h),
      //                   CustomInputForm(
      //                     labelText: "Password",
      //                     hintText: "Enter your password",
      //                     hintStyle: TextStyle(
      //                         color: Constants.primaryColor, fontSize: 10.sp),
      //                     controller: passwordController,
      //                     keyBoardInputType: TextInputType.visiblePassword,
      //                     obscureText: true,
      //                     validator: validatePassword,
      //                     onSaved: (value) => _password = value!,
      //                   ),
      //                   SizedBox(height: 30.h),
      //                   if (errorMessage.isNotEmpty)
      //                     Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Text(errorMessage,
      //                           style: const TextStyle(color: Colors.red)),
      //                     ),

      //                   if (categories.isNotEmpty)
      //                     CustomSelectForm(
      //                       categories: categories.map((e) => e.name).toList(),
      //                       selectedCategory: selectedCategory!.name,
      //                       onChanged: (String? newValue) {
      //                         setState(() {
      //                           selectedCategory = categories
      //                               .firstWhere((cat) => cat.name == newValue);
      //                           _category = selectedCategory!.id.toString();
      //                         });
      //                       },
      //                       onSaved: (value) => _category = value!,
      //                     ),
      //                   SizedBox(height: 10.h),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     children: [
      //                       Expanded(
      //                         flex: 5,
      //                         child: RadioButtonFormInput(
      //                           onSelectedItemChanged: handleSelectedItemChange,
      //                           title: 'Freelancer',
      //                           groupValue: _selectedItem,
      //                           value: '1',
      //                           onSaved: (value) => _selectedItem = value!,
      //                         ),
      //                       ),
      //                       Expanded(
      //                         flex: 5,
      //                         child: RadioButtonFormInput(
      //                           onSelectedItemChanged: handleSelectedItemChange,
      //                           title: 'Employer',
      //                           groupValue: _selectedItem,
      //                           value: '2',
      //                           onSaved: (value) => _selectedItem = value!,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               )),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget _submitButton(AuthProvider authProvider) {
    return Container(
      child: authProvider.isLoading
          ? const WaveSpinKit()
          : FormButton(
              fullWidth: true,
              variant: FormButtonVariant.filled,
              text: 'Update',
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  var payload = {
                    'firstName': firstNameController.text.trim(),
                    'lastName': lastNameController.text.trim(),
                    'email': emailController.text.trim(),
                    'phoneNumber': phoneNumberController.text.trim(),
                    'password': passwordController.text.trim(),
                    'category': selectedCategory?.id,
                    'userType': _selectedItem,
                  };

                  authProvider.register(payload).then((success) => {
                        if (success)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(authProvider.errorMessage)),
                            ),
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => VerificationPage(
                                    email: emailController.text.trim())))
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(authProvider.errorMessage)),
                            )
                          }
                      });
                }
              },
            ),
    );
  }

  String? validatePhoneNumber(String? phoneNumber) {
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

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password cannot be empty";
    }
    List<String> errors = [];
    if (password.length < 6) {
      errors.add('Password must be longer than 6 characters.');
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add('Uppercase letter is missing.');
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add('Lowercase letter is missing.');
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      errors.add('Digit is missing.');
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      errors.add('Special character is missing.');
    }

    return errors.isEmpty ? null : errors.join('\n');
  }
}
