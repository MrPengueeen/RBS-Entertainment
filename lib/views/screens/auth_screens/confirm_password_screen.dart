import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:RBS/colors.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/auth_screens/sign_up_screen.dart';
import 'package:RBS/views/shared_widgets/custom_button.dart';
import 'package:RBS/views/shared_widgets/custom_textfield.dart';
import 'package:RBS/views/screens/auth_screens/sign_in_screen.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  @override
  _ConfirmPasswordScreenState createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _otp = '';
  String _password = '';

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
                        hintText: "OTP",
                        icon: Icons.alternate_email,
                        onChanged: (value) {
                          _otp = value;
                        },
                        validator: (value) =>
                            value.isEmpty ? 'This field is required' : null,
                      ),

                      CustomTextField(
                        isPassword: true,
                        hintText: "New Password",
                        icon: Icons.lock_outline,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) => value.length < 6
                            ? 'Password must be at least 6 characters long'
                            : null,
                      ),

                      CustomButton(
                          text: "RESET PASSWORD",
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              hideKeyboard(context);

                              setState(() {
                                isLoading = true;
                              });

                              var request = {
                                'otp': _otp.trim(),
                                'new_password': _password,
                              };

                              confirmPassword(request).then((response) {
                                VxToast.show(context,
                                    msg: 'Password Successfully Reset');
                                setState(() {
                                  isLoading = false;
                                });
                                context.nextAndRemoveUntilPage(SignInScreen());
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
