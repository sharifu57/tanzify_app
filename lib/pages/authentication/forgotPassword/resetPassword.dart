import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/containers/bazierContainer.dart';
import 'package:tanzify_app/components/form/customInputForm.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/pages/authentication/login.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/utils/customDialog.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController passwordController;
  late TextEditingController repasswordController;
  final _formKey = GlobalKey<FormState>();

  String _password = "";
  final String _password2 = "";

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenUtil.init(context,
          designSize: const Size(360, 690), minTextAdapt: true);
    });
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
    final fullHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    final errorMessage = authProvider.errorMessage;
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);
    return Scaffold(
      body: SizedBox(
          height: fullHeight,
          child: Stack(children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .17,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildForm(authProvider),
            ),
          ])),
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
            child: Text("Create New Password",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text(
              "Your new password must be different from previously used password."),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
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
                    if (!_isPasswordValid(value)) {
                      return "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character";
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                SizedBox(height: 30.h),
                CustomInputForm(
                  labelText: "Re-Enter Password",
                  hintText: "Re-Enter your password",
                  hintStyle:
                      TextStyle(color: Constants.primaryColor, fontSize: 10.sp),
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
                SizedBox(height: 20.h),
                authProvider.isLoading
                    ? const WaveSpinKit()
                    : FormButton(
                        fullWidth: true,
                        text: "Reset Password",
                        variant: FormButtonVariant.filled,
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            authProvider
                                .resetPassword(
                                    widget.email, passwordController.text)
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
                                              builder: (context) =>
                                                  const LoginPage()));
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

  Widget _submitButton(AuthProvider authProvider) {
    return authProvider.isLoading
        ? const WaveSpinKit()
        : FormButton(
            variant: FormButtonVariant.filled,
            text: 'Confirm',
            onClick: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              //   authProvider
              //       .verifyPasswordOTP(widget.email, _otp)
              //       .then((success) => {
              //             if (!success)
              //               {
              //                 showCustomDialog(
              //                   context,
              //                   CustomDialog(
              //                     message: authProvider.errorMessage,
              //                     onOkPressed: () {
              //                       Navigator.pop(context);
              //                     },
              //                     onCancelPressed: () {},
              //                     type: 4,
              //                   ),
              //                 )
              //               }
              //             else
              //               {
              //                 showCustomDialog(
              //                   context,
              //                   CustomDialog(
              //                     message: authProvider.successMessage,
              //                     onOkPressed: () {
              //                       Navigator.pop(context);
              //                       Navigator.of(context).push(
              //                           CupertinoPageRoute(
              //                               builder: (context) => ResetPassword(
              //                                   email: widget.email)));
              //                     },
              //                     onCancelPressed: () {},
              //                     type: 2,
              //                   ),
              //                 )
              //               }
              //           });
              // }
            });
  }
}
