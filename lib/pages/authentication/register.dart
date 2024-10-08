import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/containers/bazierContainer.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/radioButtonInputForm.dart';
import 'package:tanzify_app/components/form/selectInputForm.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/data/providers/categoryProvider.dart';
import 'package:tanzify_app/models/category/categoryModal.dart';
import 'package:tanzify_app/pages/authentication/login.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/authentication/verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:tanzify_app/utils/customDialog.dart';

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
  final repasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _phoneNumber = "";
  String _category = "";
  bool? _isAcceptedTerm;

  CategoryModel? selectedCategory;
  String _selectedItem = "1";

  void handleSelectedItemChange(String? value) {
    setState(() {
      _selectedItem = value ?? "1";
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

  bool _validatePasswords(String password, String repassword) {
    return password == repassword;
  }

  bool _isPasswordValid(String password) {
    // At least 8 characters, at least one uppercase letter, one lowercase letter, one number and one special character
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categoryList;
    final isLoading = categoryProvider.isLoading;
    final errorMessage = categoryProvider.errorMessage;
    final fullHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);

    print("================categories");
    print(categories);
    print("================end categories");

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
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * .2),
          const SizedBox(width: 80, child: AppLogo()),
          SizedBox(
            height: 30.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Register",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Constants.primaryColor),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Please Create account",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
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
                            icon: Icons.person,
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
                            icon: Icons.person,
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
                    SizedBox(height: 15.h),
                    CustomInputForm(
                      labelText: "Email",
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Constants.primaryColor, fontSize: 10.sp),
                      controller: emailController,
                      keyBoardInputType: TextInputType.emailAddress,
                      obscureText: false,
                      icon: Icons.mail,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "Email enter a valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 15.h),
                    CustomInputForm(
                      labelText: "Phone",
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Constants.primaryColor, fontSize: 10.sp),
                      controller: phoneNumberController,
                      keyBoardInputType: TextInputType.phone,
                      obscureText: false,
                      icon: Icons.phone,
                      validator: validatePhoneNumber,
                      onSaved: (value) => _phoneNumber = value!,
                    ),
                    SizedBox(height: 15.h),
                    CustomInputForm(
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                          color: Constants.primaryColor, fontSize: 10.sp),
                      controller: passwordController,
                      keyBoardInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      icon: Icons.fingerprint,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        if (!_isPasswordValid(value)) {
                          return "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character";
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                    SizedBox(height: 15.h),
                    CustomInputForm(
                      labelText: "Re-Enter Password",
                      hintText: "Re-Enter your password",
                      hintStyle: TextStyle(
                          color: Constants.primaryColor, fontSize: 10.sp),
                      controller: repasswordController,
                      keyBoardInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      icon: Icons.fingerprint,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return "Password must be at least 6 characters";
                        } else if (!_validatePasswords(
                            passwordController.text, value)) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                    SizedBox(height: 15.h),
                    // if (errorMessage.isNotEmpty)
                    //   Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Text(errorMessage,
                    //         style: const TextStyle(color: Colors.red)),
                    //   ),
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
                        },
                        onSaved: (value) => _category = value!,
                      ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Checkbox(
                          value: _isAcceptedTerm ?? false,
                          onChanged: (value) {
                            setState(() {
                              _isAcceptedTerm = value!;
                            });
                          },
                        ),
                        // Row(
                        //   children: [
                        //     const Text("I have read"),
                        //     TextButton(
                        //         onPressed: () {
                        //           _showTermsAndCondition(context);
                        //         },
                        //         child: const Text('Policy Terms'))
                        //   ],
                        // )

                        const Text("I have accepted terms and conditions")
                      ],
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 0.h,
          ),
          _submitButton(authProvider),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryColor),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showTermsAndCondition(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Terms and conditions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getLongText(),
                    style: TextStyle(),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  String _getLongText() {
    return '''
    text hrtr
    ''';
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
                    'firstName': firstNameController.text.trim(),
                    'lastName': lastNameController.text.trim(),
                    'email': emailController.text.trim(),
                    'phoneNumber': phoneNumberController.text.trim(),
                    'password': passwordController.text.trim(),
                    'category': selectedCategory?.id,
                    'userType': _selectedItem,
                    'is_accepted_term': _isAcceptedTerm
                  };

                  authProvider.register(payload).then((success) => {
                        if (success)
                          {
                            showCustomDialog(
                              context,
                              CustomDialog(
                                message: authProvider.successMessage,
                                onOkPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => VerificationPage(
                                          email: emailController.text.trim())));
                                },
                                onCancelPressed: () {},
                                type: 2,
                              ),
                            )
                          }
                        else
                          {
                            showCustomDialog(
                              context,
                              CustomDialog(
                                message: authProvider.errorMessage,
                                onOkPressed: () {
                                  Navigator.pop(context);
                                },
                                onCancelPressed: () {},
                                type: 4,
                              ),
                            )
                          }
                      });
                }
              },
            ),
    );
  }
}
