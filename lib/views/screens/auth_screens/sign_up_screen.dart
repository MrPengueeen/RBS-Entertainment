import 'dart:ui';

import 'package:RBS/colors.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/auth_screens/sign_in_screen.dart';
import 'package:RBS/views/shared_widgets/button_widget.dart';
import 'package:RBS/views/shared_widgets/custom_button.dart';
import 'package:RBS/views/shared_widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
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
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          Image.asset(
                            'assets/logos/logo_big.png',
                            height: 45,
                            width: 54,
                            alignment: Alignment.centerLeft,
                          ).pOnly(bottom: 15),
                          Text('Sign up').text.white.bold.xl3.make(),
                          Text(
                            'Sign up and start your free month',
                            style: TextStyle(color: kColorText),
                          ).text.make().pOnly(bottom: 30),
                          Text('Name').text.xl.white.make(),
                          CustomTextField(
                            hintText: "Name",
                            icon: Icons.person,
                            onChanged: (value) => _name = value,
                            validator: (value) =>
                                value.isEmpty ? 'This field is required' : null,
                          ).paddingBottom(20),
                          Text('Phone Number').text.xl.white.make(),
                          CustomTextField(
                            hintText: "Phone Number",
                            icon: Icons.phone,
                            onChanged: (value) => _phone = value,
                            validator: (value) =>
                                value.isEmpty ? 'This field is required' : null,
                          ).paddingBottom(20),
                          Text('Email').text.xl.white.make(),
                          CustomTextField(
                            hintText: "Email (Optional)",
                            icon: Icons.alternate_email,
                            onChanged: (value) => _email = value,
                            // validator: (value) =>
                            //     value.isEmpty ? 'This field is required' : null,
                          ).paddingBottom(20),
                          Text('Password').text.xl.white.make(),
                          CustomTextField(
                            isPassword: true,
                            hintText: "Password",
                            icon: Icons.lock_outline,
                            onChanged: (value) => _password = value,
                            validator: (value) => value.length < 6
                                ? 'Password must be at least 6 characters long'
                                : null,
                          ).paddingBottom(20),
                          Text('Confirm password').text.xl.white.make(),
                          CustomTextField(
                            isPassword: true,
                            hintText: "Confirm Password",
                            icon: Icons.lock_outline,
                            validator: (value) => value != _password
                                ? 'Password don\'t match'
                                : null,
                          ).paddingBottom(20),
                          FormField<bool>(
                            builder: (state) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor: Colors.red),
                                        child: Checkbox(
                                            checkColor: kColorWhite,
                                            activeColor: kColorRed,
                                            value: checkBoxValue,
                                            onChanged: (value) {
                                              setState(() {
                                                checkBoxValue = value;
                                                state.didChange(value);
                                              });
                                            }),
                                      ),
                                      Flexible(
                                        child: Text(
                                                'I accept terms and conditions')
                                            .text
                                            .white
                                            .make(),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.errorText ?? '',
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                    ),
                                  )
                                ],
                              );
                            },
                            validator: (value) => checkBoxValue
                                ? null
                                : 'You must accept terms and conditions',
                          ),
                          CustomButtonWidget(
                            text: "Create an account",
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
                                  'is_agreed': 'true',
                                  'is_viewer': 'true',
                                };

                                if (_email.trim().isNotEmpty) {
                                  request['email'] = _email.trim();
                                }
                                registerUser(request).then((response) {
                                  toast('Sign up successful');
                                  // VxToast.show(context,
                                  //     msg: 'Sign-up successful');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  context
                                      .nextAndRemoveUntilPage(SignInScreen());
                                }).catchError((error) {
                                  VxToast.show(context,
                                      msg: '${error.toString()}');
                                  print('here');
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                            },
                          ).pOnly(top: 10),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Already have an account? ",
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(
                                          color: kColorRed,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            context.nextPage(SignInScreen()),
                                    ),
                                  ])).pOnly(bottom: 20),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                            child: BackdropFilter(
                      child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                      ),
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    ).center().visible(isLoading))
                        .center(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
