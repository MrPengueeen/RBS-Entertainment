import 'package:RBS/colors.dart';
import 'package:RBS/constants.dart';
import 'package:RBS/views/screens/auth_screens/sign_in_screen.dart';
import 'package:RBS/views/screens/auth_screens/sign_up_screen.dart';
import 'package:RBS/views/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: VStack([
        Text(APP_NAME).text.xl5.bold.white.make(),
        // Image.asset('assets/images/app_logo.jpg',
        //     width: 150, height: 150, fit: BoxFit.contain),
        CustomButton(
            text: "SIGN IN",
            press: () => context.nextReplacementPage(SignInScreen())),
        CustomButton(
            text: "REGISTER",
            press: () => context.nextReplacementPage(SignUpScreen()))
      ], crossAlignment: CrossAxisAlignment.center)
          .centered(),
    );
  }
}
