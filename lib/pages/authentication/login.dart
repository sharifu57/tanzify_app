import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/pages/constants.dart';
import '../../components/form/customInputForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Constants.primaryColor,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new_outlined, size: 13.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 80.h, child: Center(child: AppLogo())),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text("Log in to Tanzify",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInputForm(
                      labelText: "Email",
                      hintText: "Enter your email address",
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
                    SizedBox(height: 20.h),
                    authProvider.isLoading
                        ? const CircularProgressIndicator()
                        : FormButton(
                            fullWidth: true,
                            text: "Log In",
                            variant: FormButtonVariant.filled,
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                authProvider
                                    .login(_email, _password)
                                    .then((success) {
                                  if (!success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text(authProvider.errorMessage)),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text(authProvider.errorMessage)),
                                    );
                                    // Navigate to another page or do something else
                                  }
                                });
                              }
                            }),

                    // if (authProvider.errorMessage.isNotEmpty)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 8.0),
                    //     child: Text(authProvider.errorMessage,
                    //         style: TextStyle(color: Colors.red)),
                    //   )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
