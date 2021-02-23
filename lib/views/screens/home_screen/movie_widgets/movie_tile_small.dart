import 'package:RBS/colors.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/views/screens/home_screen/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieTileSmallWidget extends StatelessWidget {
  final String name;
  final String image;
  final MovieModel movie;

  const MovieTileSmallWidget({Key key, this.name, this.image, this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: MovieDetailsScreen(movie: movie),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
          margin: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 80.0,
              width: 140.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      image,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ).pOnly(bottom: 10),
            SizedBox(
                width: 150,
                child: Text(name,
                        style: TextStyle(color: kColorWhite.withOpacity(0.8)))
                    .text
                    .xs
                    .bold
                    .make()
                    .pOnly(bottom: 10)),
          ])),
    );
  }
}
