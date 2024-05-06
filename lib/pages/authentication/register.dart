import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanzify_app/components/containers/bazierContainer.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/form/selectInputForm.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/pages/authentication/login.dart';
import 'package:tanzify_app/pages/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.title});

  final String? title;

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: Text(
        'Register Now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'd',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        _entryField("Email id"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  // ignore: unused_field

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _phoneNumber = "";
  List<String> categories = [];
  String selectedCategory = "";

  @override
  void initState() {
    super.initState();
    fetchCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
    });
  }

  void fetchCategories() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Simulate fetched data
    setState(() {
      categories = ['Technology', 'Business', 'Art', 'Science'];
      selectedCategory = categories[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);
    return Scaffold(
      body: SizedBox(
        height: fullHeight,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .17,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: fullHeight * .2),
                    const AppLogo(),
                    SizedBox(
                      height: 50.h,
                    ),
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
                    if (categories.isNotEmpty)
                      CustomSelectForm(
                        categories: categories,
                        selectedCategory: selectedCategory,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                      ),
                    // _emailPasswordWidget(),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // _submitButton(),
                    // SizedBox(height: fullHeight * .14),
                    // _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 30, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
