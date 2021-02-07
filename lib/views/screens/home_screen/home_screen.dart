import 'package:RBS/colors.dart';
import 'package:RBS/views/screens/home_screen/movie_tab.dart';
import 'package:RBS/views/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: CustomAppBar(),
          // appBar: AppBar(
          //   leading: Image.asset(
          //     'assets/logos/rbs_logo.png',
          //   ).p16(),
          //   actions: [
          //     TabBar(tabs: [
          //       Tab(icon: Icon(Icons.directions_car)),
          //       Tab(icon: Icon(Icons.directions_transit)),
          //       Tab(icon: Icon(Icons.directions_bike)),
          //     ]),
          //   ],
          // ),
          body: SafeArea(
            child: TabBarView(
              children: [
                MovieTab(),
                Container(child: Icon(Icons.download_done_outlined)),
                Container(child: Icon(Icons.person))
              ],
            ),
          ),
        ));
  }
}
