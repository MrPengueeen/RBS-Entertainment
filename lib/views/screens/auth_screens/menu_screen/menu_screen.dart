import 'package:RBS/colors.dart';
import 'package:RBS/services/network/api_handlers.dart';
import 'package:RBS/views/screens/auth_screens/menu_screen/subscription_screen.dart';
import 'package:RBS/views/screens/bottom_navbar_screen.dart';
import 'package:RBS/views/screens/welcome_screen.dart';
import 'package:RBS/views/shared_widgets/button_widget.dart';
import 'package:RBS/views/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoading = true;
  bool isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    isLoggedIn = await getBool(LOGGED_IN, defaultValue: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
              child: VStack(
        [
          CustomButtonWidget(
            text: 'Subscription',
            press: () {
              pushNewScreen(context,
                  screen: SubscriptionScreen(), withNavBar: true);
            },
          ),
          CustomButtonWidget(
            press: () async {
              setBool(LOGGED_IN, false);
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => BottomNavigationBarScreen()),
                  (route) => false);
            },
            color: kColorWhite,
            textColor: kColorRed,
            text: 'Sign Out',
          ).visible(isLoggedIn),
          CustomButtonWidget(
            press: () async {
              pushNewScreen(
                context,
                screen: WelcomeScreen(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            color: kColorWhite,
            textColor: kColorRed,
            text: 'Sign in',
          ).visible(!isLoggedIn),
        ],
      ))),
    );
  }
}
