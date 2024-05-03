import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tanzify_app/components/logo/logo.dart';
import 'package:tanzify_app/data/providers/userProvider.dart';
import 'package:tanzify_app/pages/constants.dart';

import '../../components/form/customInputForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Constants.primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 13,
          ),
        ),
      ),
      body: Scaffold(
          body: Column(
        children: <Widget>[
          SizedBox(
            height: fullHeight / 6,
            child: const Center(
              child: AppLogo(),
            ),
          ),
          const SizedBox(
            child: Center(
              child: Text("Login to Tanzify"),
            ),
          ),
          Expanded(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomInputForm(
                          labelText: "Email",
                          hintText: "Enter your email address",
                          controller: emailController,
                          keyBoardInputType: TextInputType.emailAddress,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is Required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          // child: Consumer<UserProvider>(
                          //     builder: (context, user, _) =>
                          //         Text(user.name))),
                          child: const Text('login'),
                        )
                      ],
                    ),
                  )))
        ],
      )),
    );
  }
}
