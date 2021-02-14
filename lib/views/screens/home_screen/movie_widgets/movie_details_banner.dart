import 'package:RBS/colors.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/services/network/api_handlers.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/play_movie.dart';
import 'package:RBS/views/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieBannerWidget extends StatefulWidget {
  final MovieModel movie;

  const MovieBannerWidget({Key key, this.movie}) : super(key: key);

  @override
  _MovieBannerWidgetState createState() => _MovieBannerWidgetState();
}

class _MovieBannerWidgetState extends State<MovieBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              height: 500.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    'https://posteritati.com/posters/000/000/051/575/beauty-and-the-beast-sm-web.jpg',
                  ),
                ),
              )),
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  kPrimaryColor,
                  kPrimaryColor.withOpacity(0.6),
                  kPrimaryColor.withOpacity(0),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: playMovie,
                    child: VxCircle(
                      backgroundColor: kColorRed,
                      radius: 50,
                      child: Icon(
                        Icons.play_arrow_outlined,
                        color: kColorWhite,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Watch Now')
                          .text
                          .xl2
                          .bold
                          .white
                          .make()
                          .pOnly(bottom: 7),
                      Text('152 Minutes').text.white.make(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  playMovie() async {
    bool isLoggedIn = await getBool(LOGGED_IN);
    pushNewScreen(
      context,
      screen: isLoggedIn
          ? PlayMovieScreen(url: widget.movie.video)
          : WelcomeScreen(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
