import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/button/formButton.dart';
import 'package:tanzify_app/components/containers/bazierContainer.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/data/providers/authProvider.dart';
import 'package:tanzify_app/pages/authentication/forgotPassword/resetPassword.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'package:tanzify_app/utils/customDialog.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _formKey = GlobalKey<FormState>();
  String _otp = "";
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
              child: buildForm(errorMessage, authProvider),
            ),
            Positioned(top: 30, left: 0, child: _backButton()),
          ])),
    );
  }

  Widget buildForm(String errorMessage, AuthProvider authProvider) {
    Color accentPurpleColor = const Color(0xFF6A53A1);
    Color primaryColor = const Color(0xFF121212);
    Color accentPinkColor = const Color(0xFFF99BBD);
    Color accentDarkGreenColor = const Color(0xFF115C49);
    Color accentYellowColor = const Color(0xFFFFB612);
    Color accentOrangeColor = const Color(0xFFEA7A3B);

    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return null;

      // return theme.textTheme.headline3?.copyWith(color: color);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * .2),
          const AppLogo(),
          SizedBox(
            height: 40.h,
          ),
          SizedBox(
            height: 50.h,
            child: const Text(
              "Verify Email",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              height: 30.h,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'A verification code has been sent to\n',
                        ),
                        TextSpan(
                          text: widget.email,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ))),
          SizedBox(
            height: 70.h,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    OtpTextField(
                      numberOfFields: 4,
                      borderColor: accentPurpleColor,
                      focusedBorderColor: Constants.primaryColor,
                      showFieldAsBox: false,
                      borderWidth: 4.0,
                      onCodeChanged: (String code) {
                        //handle validation or checks here if necessary
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        setState(() {
                          _otp = verificationCode;
                        });
                      },
                    ),
                  ],
                )),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Did not get the code?'),
                TextButton(
                    onPressed: () {
                      authProvider
                          .resendVerificationCode(widget.email)
                          .then((success) {
                        if (!success) {
                          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                            content: Text(authProvider.errorMessage),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                            content: Text(authProvider.successMessage),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          )));
                        }
                      });
                    },
                    child: authProvider.smallLoading
                        ? const WaveSpinKit()
                        : const Text('Resend'))
              ],
            ),
          ),
          SizedBox(
            // height: 40.h,
            child: _submitButton(authProvider),
          )
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
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                authProvider
                    .verifyPasswordOTP(widget.email, _otp)
                    .then((success) => {
                          if (!success)
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
                          else
                            {
                              showCustomDialog(
                                context,
                                CustomDialog(
                                  message: authProvider.successMessage,
                                  onOkPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) => ResetPassword(
                                                email: widget.email)));
                                  },
                                  onCancelPressed: () {},
                                  type: 2,
                                ),
                              )
                            }
                        });
              }
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
}
