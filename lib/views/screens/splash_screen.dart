import 'package:RBS/colors.dart';
import 'package:RBS/constants.dart';
import 'package:RBS/services/network/api_handlers.dart';
import 'package:RBS/views/screens/bottom_navbar_screen.dart';
import 'package:RBS/views/screens/welcome_screen.dart';
import 'package:RBS/views/shared_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), () async {
      // bool isLoggedIn = await getBool(LOGGED_IN, defaultValue: false);

      context.nextReplacementPage(BottomNavigationBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: VStack([
        // Text(APP_NAME).text.xl5.bold.white.make().pOnly(bottom: 20),
        Image.asset(
          'assets/logos/logo_big.png',
          height: 100,
          width: 100,
        ),
        //LoadingWidget(),
      ], crossAlignment: CrossAxisAlignment.center)
          .centered(),
    );
  }
}
