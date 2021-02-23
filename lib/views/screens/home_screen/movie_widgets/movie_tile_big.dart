import 'package:RBS/colors.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/views/screens/home_screen/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieTileBigWidget extends StatelessWidget {
  final MovieModel movie;
  final String name;
  final String image;
  final String rating;
  final List<String> genre;
  final int reviews;

  const MovieTileBigWidget(
      {Key key,
      this.movie,
      this.name,
      this.image,
      this.rating,
      this.genre,
      this.reviews})
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
          margin: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 265.0,
                    width: 247.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            image,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: VxCircle(
                        radius: 50,
                        backgroundColor: kColorRed,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: kColorWhite,
                        )),
                  )
                ],
              ).pOnly(bottom: 17),
              SizedBox(
                  width: 220,
                  child: Text(name, style: TextStyle(fontSize: 17))
                      .text
                      .bold
                      .white
                      .make()
                      .pOnly(bottom: 10)),
              SizedBox(
                width: 220,
                child: Text(
                  genre.join(', '),
                  style: TextStyle(
                      color: kColorWhite.withOpacity(0.7), fontSize: 12),
                ).pOnly(bottom: 10),
              ),
              HStack([
                Icon(
                  Icons.star,
                  color: kColorRed,
                ),
                Text(
                  ' ${rating} (${reviews} Reviews)',
                  style: TextStyle(
                      color: kColorWhite.withOpacity(0.7), fontSize: 12),
                )
              ])
            ],
          )),
    );
  }
}
