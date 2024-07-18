import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/containers/bazierContainer.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/pages/authentication/authPage.dart';
import 'package:tanzify_app/pages/authentication/forgotPassword/forgotPassword.dart';
import 'package:tanzify_app/pages/authentication/register.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/pages/mainApp.dart';
import '../../components/form/customInputForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
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
    final fullHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildForm(authProvider),
            ),
            Positioned(top: 30, left: 0, child: _backButton()),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => const AuthPage()));
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

  Widget _buildForm(AuthProvider authProvider) {
    return SingleChildScrollView(
      // padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * .2),
          const SizedBox(width: 150, child: AppLogo()),
          SizedBox(
            height: 50.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Login",
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
              "Please Sign In to continue",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomInputForm(
                  labelText: "Email",
                  hintText: "Enter your email address",
                  hintStyle:
                      TextStyle(color: Constants.primaryColor, fontSize: 10.sp),
                  controller: emailController,
                  keyBoardInputType: TextInputType.emailAddress,
                  obscureText: false,
                  icon: LineAwesomeIcons.mail_bulk_solid,
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
                  labelText: "Password",
                  hintText: "Enter your password",
                  hintStyle:
                      TextStyle(color: Constants.primaryColor, fontSize: 10.sp),
                  controller: passwordController,
                  keyBoardInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  icon: Icons.fingerprint,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        navigateToPage(pathName: 'forgot-password');
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Constants.primaryColor, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                authProvider.isLoading
                    ? const WaveSpinKit()
                    : FormButton(
                        fullWidth: true,
                        text: "Sign In",
                        variant: FormButtonVariant.filled,
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            authProvider
                                .login(emailController.text,
                                    passwordController.text)
                                .then((success) {
                              if (!success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(authProvider.errorMessage)),
                                );
                              } else {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => const MainApp()));
                              }
                            });
                          }
                        }),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => const RegisterPage()));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants.primaryColor),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  navigateToPage({required final String pathName}) async {
    if (pathName == 'forgot-password') {
      await Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const ForgotPassword()));
    } else if (pathName == 'register') {
      await Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => const RegisterPage()));
    }
  }
}
