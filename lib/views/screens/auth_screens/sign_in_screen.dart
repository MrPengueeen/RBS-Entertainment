import 'dart:ui';

import 'package:RBS/colors.dart';
import 'package:RBS/services/network/api_handlers.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/auth_screens/sign_up_screen.dart';
import 'package:RBS/views/shared_widgets/custom_button.dart';
import 'package:RBS/views/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email = '';

  String _password = '';

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/app_logo.jpg',
                      //     width: 150, height: 150, fit: BoxFit.contain),
                      CustomTextField(
                        hintText: "Email / Phone Number",
                        icon: Icons.alternate_email,
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) =>
                            value.isEmpty ? 'This field is required' : null,
                      ),
                      CustomTextField(
                        isPassword: true,
                        hintText: "Password",
                        icon: Icons.lock_outline,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) => value.length < 6
                            ? 'Password must be at least 6 characters long'
                            : null,
                      ),
                      CustomButton(
                          text: "SIGN IN",
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              setBool(LOGGED_IN, false);
                              hideKeyboard(context);

                              setState(() {
                                isLoading = true;
                              });

                              var request = {
                                'username': _email.trim(),
                                'password': _password
                              };

                              signInUser(request).then((response) {
                                setString(ACCESS, response['token']);
                                setBool(LOGGED_IN, true);
                                setString(USERNAME, response['username']);
                                VxToast.show(context, msg: 'Login Successful');
                                setState(() {
                                  isLoading = false;
                                });
                              }).catchError((error) {
                                // VxToast.show(context,
                                //     msg: '${error.toString()}');
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            }
                          }).pOnly(top: 10),
                      Text("Don't have an account? REGISTER")
                          .text
                          .white
                          .make()
                          .onInkTap(
                              () => context.nextReplacementPage(SignUpScreen()))
                          .p(10),
                    ],
                  ),
                ),
              ),
              Container(
                      child: BackdropFilter(
                child: CircularProgressIndicator(
                  backgroundColor: kPrimaryColor,
                ),
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              ).center().visible(isLoading))
                  .center(),
            ],
          ),
        ),
      ),
    );
  }
}
