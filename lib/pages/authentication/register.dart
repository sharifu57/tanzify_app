//   // Widget _submitButton() {
//   //   return Container(
//   //     width: MediaQuery.of(context).size.width,
//   //     padding: const EdgeInsets.symmetric(vertical: 15),
//   //     alignment: Alignment.center,
//   //     decoration: BoxDecoration(
//   //         borderRadius: const BorderRadius.all(Radius.circular(5)),
//   //         boxShadow: <BoxShadow>[
//   //           BoxShadow(
//   //               color: Colors.grey.shade200,
//   //               offset: Offset(2, 4),
//   //               blurRadius: 5,
//   //               spreadRadius: 2)
//   //         ],
//   //         gradient: const LinearGradient(
//   //             begin: Alignment.centerLeft,
//   //             end: Alignment.centerRight,
//   //             colors: [Color(0xfffbb448), Color(0xfff7892b)])),
//   //     child: Text(
//   //       'Register Now',
//   //       style: TextStyle(fontSize: 20, color: Colors.white),
//   //     ),
//   //   );
//   // }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/containers/bazierContainer.dart';
import 'package:tanzify_app/components/form/checkBoxInputForm.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/selectInputForm.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/models/categoryModal.dart';
import 'package:tanzify_app/pages/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.title});
  final String? title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _phoneNumber = "";
  String _category = "";

  CategoryModel? selectedCategory;
  String _selectedItem = "1";

  void handleSelectedItemChange(String? value) {
    setState(() {
      _selectedItem = value ?? "1"; // Assuming "1" is a safe default
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getCategories();
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
    });
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categoryList;
    final isLoading = categoryProvider.isLoading;
    final errorMessage = categoryProvider.errorMessage;
    final fullHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);

    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      body: isLoading
          ? const Center(child: WaveSpinKit())
          : SizedBox(
              height: fullHeight,
              child: Stack(children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .17,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: buildForm(categories, errorMessage, authProvider),
                ),
                Positioned(top: 30, left: 0, child: _backButton()),
              ])),
    );
  }

  Widget buildForm(List<CategoryModel> categories, String errorMessage,
      AuthProvider authProvider) {
    if (categories.isNotEmpty && selectedCategory == null) {
      selectedCategory = categories.first;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * .2),
          const AppLogo(),
          SizedBox(
            height: 50.h,
          ),
          SizedBox(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomInputForm(
                            labelText: "First Name",
                            hintText: "Enter your first name",
                            hintStyle: TextStyle(
                                color: Constants.primaryColor, fontSize: 10.sp),
                            controller: firstNameController,
                            keyBoardInputType: TextInputType.text,
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "First name is required";
                              }
                              return null;
                            },
                            onSaved: (value) => _firstName = value!,
                          ),
                        ),
                        SizedBox(width: 10.w), // Space between the input fields
                        Expanded(
                          child: CustomInputForm(
                            labelText: "Last Name",
                            hintText: "Enter your last name",
                            hintStyle: TextStyle(
                                color: Constants.primaryColor, fontSize: 10.sp),
                            controller: lastNameController,
                            keyBoardInputType: TextInputType.text,
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Last name is required";
                              }
                              return null;
                            },
                            onSaved: (value) => _lastName = value!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    CustomInputForm(
                      labelText: "Email",
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Constants.primaryColor, fontSize: 10.sp),
                      controller: emailController,
                      keyBoardInputType: TextInputType.emailAddress,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "Email enter a valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 30.h),
                    CustomInputForm(
                      labelText: "Phone",
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Constants.primaryColor, fontSize: 10.sp),
                      controller: phoneNumberController,
                      keyBoardInputType: TextInputType.phone,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone number is required";
                        }
                        return null;
                      },
                      onSaved: (value) => _phoneNumber = value!,
                    ),
                    SizedBox(height: 30.h),
                    CustomInputForm(
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                          color: Constants.primaryColor, fontSize: 10.sp),
                      controller: passwordController,
                      keyBoardInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                    SizedBox(height: 30.h),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(errorMessage,
                            style: const TextStyle(color: Colors.red)),
                      ),
                    if (categories.isNotEmpty)
                      CustomSelectForm(
                        categories: categories.map((e) => e.name).toList(),
                        selectedCategory: selectedCategory!.name,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = categories
                                .firstWhere((cat) => cat.name == newValue);
                            _category = selectedCategory!.id.toString();
                          });
                          print("======start selected category======");
                          print(selectedCategory);
                          print(
                              "Selected Category ID: ${selectedCategory!.id}");
                        },
                        onSaved: (value) => _category = value!,
                      ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 5,
                          child: CustomCheckFormInput(
                            onSelectedItemChanged: handleSelectedItemChange,
                            title: 'Freelancer',
                            groupValue: _selectedItem,
                            value: '1',
                            onSaved: (value) => _selectedItem = value!,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomCheckFormInput(
                            onSelectedItemChanged: handleSelectedItemChange,
                            title: 'Employer',
                            groupValue: _selectedItem,
                            value: '2',
                            onSaved: (value) => _selectedItem = value!,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 0.h,
          ),
          _submitButton(authProvider),
        ],
      ),
    );
  }

  Widget _submitButton(AuthProvider authProvider) {
    return Container(
      child: authProvider.isLoading
          ? const WaveSpinKit()
          : FormButton(
              fullWidth: true,
              variant: FormButtonVariant.filled,
              text: 'Register',
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  var payload = {
                    'first_name': firstNameController.text.trim(),
                    'last_name': lastNameController.text.trim(),
                    'email': emailController.text.trim(),
                    'phone_number': phoneNumberController.text.trim(),
                    'password': passwordController.text.trim(),
                    'category': _category,
                    'user_type': _selectedItem,
                  };

                  print("===this is my payload");
                  authProvider.register(payload).then((success) => {
                        if (success)
                          {print("=======success")}
                        else
                          {print("========failed")}
                      });
                }
              },
            ),
    );
  }
}
