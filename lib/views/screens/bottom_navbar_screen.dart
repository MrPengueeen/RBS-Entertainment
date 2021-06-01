import 'package:RBS/colors.dart';
import 'package:RBS/custom_icons_icons.dart';
import 'package:RBS/models/menu_model.dart';
import 'package:RBS/views/screens/auth_screens/menu_screen/menu_screen.dart';
import 'package:RBS/views/screens/downloads_screen/download_screen.dart';
import 'package:RBS/views/screens/home_screen/home_screen.dart';
import 'package:RBS/views/screens/home_screen/movie_details_screen.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/notification_widget.dart';
import 'package:RBS/views/screens/search_screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  BottomNavigationBarScreen({Key key}) : super(key: key);

  @override
  BottomNavigationBarScreenState createState() =>
      BottomNavigationBarScreenState();
}

class BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<MenuModel> menuItems = List<MenuModel>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getMenuItems();
  }

  Future<void> getMenuItems() async {
    await getMenuApi().then((response) {
      menuItems = (response as List).map((e) => MenuModel.fromJson(e)).toList();

      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      VxToast.show(context, msg: 'There was an error!');
    });
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        menuItems: menuItems,
      ),
      SearchScreen(),
      DownloadsScreen(),
      MenuScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CustomIcons.home),
        title: ("Home"),
        activeColorPrimary: kColorRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CustomIcons.search),
        title: ("Search"),
        activeColorPrimary: kColorRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CustomIcons.download),
        title: ("Downloads"),
        activeColorPrimary: kColorRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CustomIcons.menu),
        title: ("Menu"),
        activeColorPrimary: kColorRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
          )
        : PersistentTabView(
            context,
            controller: controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: kPrimaryColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen when keyboard appears.
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style2, // Choose the nav bar style with this property.
          );
  }
}
