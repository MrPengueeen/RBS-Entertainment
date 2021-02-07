import 'dart:ui';

import 'package:RBS/colors.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/auth_screens/sign_in_screen.dart';
import 'package:RBS/views/shared_widgets/custom_button.dart';
import 'package:RBS/views/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email = '';

  String _password = '';

  String _phone = '';

  String _name = '';

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    CustomTextField(
                      hintText: "Name",
                      icon: Icons.person,
                      onChanged: (value) => _name = value,
                      validator: (value) =>
                          value.isEmpty ? 'This field is required' : null,
                    ),
                    CustomTextField(
                      hintText: "Phone Number",
                      icon: Icons.phone,
                      onChanged: (value) => _phone = value,
                      validator: (value) =>
                          value.isEmpty ? 'This field is required' : null,
                    ),
                    CustomTextField(
                      hintText: "Email (Optional)",
                      icon: Icons.alternate_email,
                      onChanged: (value) => _email = value,
                      // validator: (value) =>
                      //     value.isEmpty ? 'This field is required' : null,
                    ),
                    CustomTextField(
                      isPassword: true,
                      hintText: "Password",
                      icon: Icons.lock_outline,
                      onChanged: (value) => _password = value,
                      validator: (value) => value.length < 6
                          ? 'Password must be at least 6 characters long'
                          : null,
                    ),
                    CustomTextField(
                      isPassword: true,
                      hintText: "Confirm Password",
                      icon: Icons.lock_outline,
                      validator: (value) =>
                          value != _password ? 'Password don\'t match' : null,
                    ),
                    CustomButton(
                      text: "REGISTER",
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          hideKeyboard(context);
                          setState(() {
                            isLoading = true;
                          });
                          //context.showLoading(msg: 'Signing up');
                          var request = {
                            'password': _password,
                            'name': _name,
                            'phone': _phone,
                          };
                          if (_email.trim().isNotEmpty) {
                            request['email'] = _email.trim();
                          }
                          registerUser(request).then((response) {
                            if (response['details'] ==
                                "User successfully registered to the RBS Entertainment") {
                              VxToast.show(context, msg: 'Sign-up successful');
                              setState(() {
                                isLoading = false;
                              });
                              context.nextAndRemoveUntilPage(SignInScreen());
                            } else {
                              VxToast.show(context,
                                  msg: 'Something went wrong');
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }).catchError((error) {
                            // VxToast.show(context,
                            //     msg: '${error.toString()}');
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
                    ).pOnly(top: 10),
                    Text("Already have an account? SIGN IN")
                        .text
                        .white
                        .make()
                        .onInkTap(
                            () => context.nextReplacementPage(SignInScreen()))
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
    );
  }
}
