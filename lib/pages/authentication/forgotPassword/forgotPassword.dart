import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/containers/bazierContainer.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/pages/authentication/authPage.dart';
import 'package:tanzify_app/pages/authentication/forgotPassword/verifyEmail.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/utils/customDialog.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  final String _password = "";

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
          const AppLogo(),
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h),
            child: Text("Forgot Password",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
          ),
          // Text(
          //     "Lost your password? Please enter your email address. You will receive an OTP to create a new password."),
          const SafeArea(
              child: Text(
                  "Lost your password? Please enter your email address. You will receive an OTP to create a new password.")),
          SizedBox(
            height: 20.h,
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
                SizedBox(height: 20.h),
                authProvider.isLoading
                    ? const WaveSpinKit()
                    : FormButton(
                        fullWidth: true,
                        text: "SEND OTP",
                        variant: FormButtonVariant.filled,
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            authProvider
                                .forgotPassword(emailController.text)
                                .then((success) {
                              if (!success) {
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
                                );
                              } else {
                                showCustomDialog(
                                  context,
                                  CustomDialog(
                                    message: authProvider.successMessage,
                                    onOkPressed: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (context) => VerifyEmail(
                                                  email:
                                                      emailController.text)));
                                    },
                                    onCancelPressed: () {},
                                    type: 2,
                                  ),
                                );
                              }
                            });
                          }
                        }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // navigateToPage({required final String pathName}) {
  //   if (pathName == 'forgot-password') {
  //     Navigator.of(context).push(
  //         CupertinoPageRoute(builder: (context) => const ForgotPassword()));
  //   } else if (pathName == 'register') {
  //     Navigator.of(context)
  //         .push(CupertinoPageRoute(builder: (context) => const RegisterPage()));
  //   }
  // }
}
