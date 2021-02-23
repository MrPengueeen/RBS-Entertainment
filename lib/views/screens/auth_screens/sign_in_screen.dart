import 'dart:ui';

import 'package:RBS/colors.dart';
import 'package:RBS/services/network/api_handlers.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/auth_screens/reset_password_screen.dart';
import 'package:RBS/views/screens/auth_screens/sign_up_screen.dart';
import 'package:RBS/views/screens/bottom_navbar_screen.dart';
import 'package:RBS/views/shared_widgets/button_widget.dart';
import 'package:RBS/views/shared_widgets/custom_button.dart';
import 'package:RBS/views/shared_widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
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
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Image.asset('assets/images/app_logo.jpg',
                            //     width: 150, height: 150, fit: BoxFit.contain),
                            Image.asset(
                              'assets/logos/logo_big.png',
                              height: 45,
                              width: 54,
                              alignment: Alignment.centerLeft,
                            ).pOnly(bottom: 15),
                            Text('Welcome back').text.white.bold.xl3.make(),
                            Text(
                              'Sign in to your account',
                              style: TextStyle(color: kColorText),
                            ).text.make().pOnly(bottom: 30),
                            Text('Email').text.xl.white.make(),
                            CustomTextField(
                              hintText: "Email / Phone",
                              icon: Icons.alternate_email,
                              onChanged: (value) {
                                _email = value;
                              },
                              validator: (value) => value.isEmpty
                                  ? 'This field is required'
                                  : null,
                            ).paddingBottom(20),
                            Text('Password').text.xl.white.make(),
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
                            Text(
                              'Forgot Password?',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: kColorWhite),
                            ).onInkTap(() {
                              context.nextPage(ResetPasswordScreen());
                            }),
                            CustomButtonWidget(
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
                                      VxToast.show(context,
                                          msg: 'Login Successful');
                                      setState(() {
                                        isLoading = false;
                                      });
                                      context.nextAndRemoveUntilPage(
                                          BottomNavigationBarScreen());
                                    }).catchError((error) {
                                      // VxToast.show(context,
                                      //     msg: '${error.toString()}');
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  }
                                }).pOnly(top: 10, bottom: 30),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "Don't have an account? ",
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: TextStyle(
                                            color: kColorRed,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () =>
                                              context.nextPage(SignUpScreen()),
                                      ),
                                    ])),
                          ],
                        ),
                      ),
                    ),
                    Container(
                            child: BackdropFilter(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                        ),
                      ),
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    ).center().visible(isLoading))
                        .center(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
