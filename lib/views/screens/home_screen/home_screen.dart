import 'package:RBS/colors.dart';
import 'package:RBS/models/menu_model.dart';
import 'package:RBS/views/screens/home_screen/home_tab.dart';
import 'package:RBS/views/screens/home_screen/movie_tab.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/notification_widget.dart';
import 'package:RBS/views/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  final List<MenuModel> menuItems;

  const HomeScreen({Key key, this.menuItems}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isNotificationOpen = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.menuItems.length + 1,
      child: Stack(children: [
        Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: CustomAppBar(
            menuItems: widget.menuItems,
          ),
          body: SafeArea(
            child: TabBarView(children: [
              HomeTab(),
              ...widget.menuItems
                  .map((e) => MovieTab(
                        menu: e,
                      ))
                  .toList()
            ]),
          ),
        ),
        Positioned(right: 28, top: 80, child: NotificationWidget())
            .visible(isNotificationOpen),
      ]),
    );
  }
}
