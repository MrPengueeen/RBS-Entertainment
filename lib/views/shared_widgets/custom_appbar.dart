import 'package:RBS/colors.dart';
import 'package:RBS/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final List<MenuModel> menuItems;

  //TabController _controller = TabController(length: 3, vsync: TickerProviderStateMixin);
  CustomAppBar({this.menuItems}) : preferredSize = Size.fromHeight(60);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller = TabController(length: 3, vsync: this);
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
          ).pLTRB(20, 16, 16, 16),
          Flexible(
            child: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                tabs: widget.menuItems
                    .map((e) => Tab(
                          text: e.title,
                        ))
                    .toList()),
          ),
          Image.asset('assets/icons/bell.png').pLTRB(16, 16, 20, 16),
        ],
        alignment: MainAxisAlignment.spaceBetween,
        axisSize: MainAxisSize.min,
      ),
    ));
  }
}
