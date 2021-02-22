import 'package:RBS/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: Text('Notifications').text.bold.make(),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'Coming Soon',
            ),
            Tab(
              text: 'Updates',
            ),
          ]),
        ),
        body: TabBarView(children: [
          Container(child: Text('All').text.white.bold.make()),
          Container(child: Text('Coming Soon').text.white.bold.make()),
          Container(child: Text('Updates').text.white.bold.make()),
        ]),
      ),
    );
  }
}
