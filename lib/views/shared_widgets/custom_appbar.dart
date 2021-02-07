import 'package:RBS/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  //TabController _controller = TabController(length: 3, vsync: TickerProviderStateMixin);
  CustomAppBar() : preferredSize = Size.fromHeight(60);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: 60,
      color: kPrimaryColor,
      child: HStack(
        [
          Image.asset(
            'assets/logos/rbs_logo.png',
          ).pLTRB(10, 16, 16, 16),
          TabBar(isScrollable: true, labelColor: Colors.white, tabs: [
            Tab(
              text: 'Movie',
            ),
            Tab(
              text: 'Drama',
            ),
            Tab(
              text: 'Series',
            ),
          ]),
          Image.asset('assets/icons/bell.png').pLTRB(16, 16, 10, 16),
        ],
        alignment: MainAxisAlignment.spaceBetween,
        axisSize: MainAxisSize.min,
      ),
    ));
  }
}
