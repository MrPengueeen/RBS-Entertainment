import 'package:RBS/colors.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/views/screens/bottom_navbar_screen.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_tile.dart';
import 'package:RBS/views/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class DownloadsScreen extends StatefulWidget {
  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              var tabController = context
                  .findAncestorStateOfType<BottomNavigationBarScreenState>();

              tabController.controller.jumpToTab(0);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kColorWhite,
            ),
          ),
          centerTitle: true,
          title:
              Image.asset('assets/logos/rbs_logo.png', width: 31.2, height: 26),
          backgroundColor: kPrimaryColor,
          actions: [
            Image.asset('assets/icons/bell.png', height: 20, width: 16)
                .pOnly(right: 20)
                .onInkTap(() {
              pushNewScreen(
                context,
                screen: NotificationScreen(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            }),
          ]),
      backgroundColor: kPrimaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:
                    (size.width * 0.4) / ((size.width * 0.4) + 50),
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            itemCount: 20,
            //controller: _sccontroller,
            itemBuilder: (_, index) {
              var movie = MovieModel(
                title: 'F9',
                description:
                    "Dominic Toretto and his crew join forces to battle the most skilled assassin and high-performance driver they've ever encountered -- his forsaken brother.",
                duration: "00:02:30",
                genre: ["Action"],
                id: 12,
                menuId: 1,
                poster:
                    "http://167.86.115.146:8099/media/poster/F9/maxresdefault.jpg",
                rating: 9,
                released: '2021',
                trailer: "https://www.youtube.com/watch?v=aSiDu3Ywi8E",
                video: "https://www.youtube.com/watch?v=aSiDu3Ywi8E",
                year: 2021,
              );
              return MovieTileWidget(
                movie: movie,
                image: movie.poster != null
                    ? movie.poster
                    : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                name: movie.title,
              );
            }),
      ),
    ));
  }
}
