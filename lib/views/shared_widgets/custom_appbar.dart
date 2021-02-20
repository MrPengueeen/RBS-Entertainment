import 'package:RBS/colors.dart';
import 'package:RBS/models/menu_model.dart';
import 'package:RBS/views/screens/home_screen/home_screen.dart';
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
  bool notificationOpen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              color: kPrimaryColor,
              child: HStack(
                [
                  Image.asset('assets/logos/rbs_logo.png',
                          width: 31.2, height: 26)
                      .pOnly(left: 20),
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
                  Image.asset('assets/icons/bell.png', height: 20, width: 16)
                      .pOnly(right: 20)
                      .onInkTap(() {
                    context
                        .findAncestorStateOfType<HomeScreenState>()
                        .setState(() {
                      context
                              .findAncestorStateOfType<HomeScreenState>()
                              .isNotificationOpen =
                          !context
                              .findAncestorStateOfType<HomeScreenState>()
                              .isNotificationOpen;
                    });
                  }),
                ],
                alignment: MainAxisAlignment.spaceBetween,
                axisSize: MainAxisSize.min,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
