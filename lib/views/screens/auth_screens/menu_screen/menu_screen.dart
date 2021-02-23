import 'package:RBS/colors.dart';
import 'package:RBS/services/network/api_handlers.dart';
import 'package:RBS/views/screens/auth_screens/menu_screen/subscription_screen.dart';
import 'package:RBS/views/screens/auth_screens/sign_in_screen.dart';
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
              child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: kColorRed,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HStack([
                  Icon(
                    Icons.person,
                    size: 50,
                    color: kColorWhite,
                  ).pOnly(right: 30),
                  Text('USER PROFILE').text.xl2.white.make(),
                ]),
                HStack([
                  Icon(
                    Icons.subscriptions,
                    size: 50,
                    color: kColorWhite,
                  ).pOnly(right: 30),
                  Text('SUBSCRIPTION DETAILS').text.xl2.white.make(),
                ]),
                HStack([
                  Icon(
                    Icons.watch_later,
                    size: 50,
                    color: kColorWhite,
                  ).pOnly(right: 30),
                  Text('WATCHED LIST').text.xl2.white.make(),
                ]),
                HStack([
                  Icon(
                    Icons.favorite,
                    size: 50,
                    color: kColorWhite,
                  ).pOnly(right: 30),
                  Text('FAVORITES LIST').text.xl2.white.make(),
                ]),
                HStack([
                  Icon(
                    Icons.download_done_outlined,
                    size: 50,
                    color: kColorWhite,
                  ).pOnly(right: 30),
                  Text('DOWNLOADS').text.xl2.white.make(),
                ]),
              ],
            ).visible(isLoggedIn),
            Column(
              children: [
                CustomButtonWidget(
                  text: 'SUBSCRIBE NOW',
                  press: () {
                    pushNewScreen(context,
                        screen: SubscriptionScreen(), withNavBar: true);
                  },
                ),
                CustomButtonWidget(
                  press: () async {
                    setBool(LOGGED_IN, false);
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => BottomNavigationBarScreen()),
                            (route) => false);
                  },
                  color: kPrimaryColor,
                  textColor: kColorWhite,
                  text: 'SIGN OUT',
                ).visible(isLoggedIn),
                CustomButtonWidget(
                  press: () async {
                    pushNewScreen(
                      context,
                      screen: SignInScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  color: kPrimaryColor,
                  textColor: kColorWhite,
                  text: 'LOGIN/SIGN UP',
                ).visible(!isLoggedIn),
              ],
            ),
          ],
        ),
      ))),
    );
  }
}
