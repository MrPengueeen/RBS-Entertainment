import 'package:RBS/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieTileBigWidget extends StatelessWidget {
  final String name;
  final String image;
  final String rating;
  final List<String> genre;
  final int reviews;

  const MovieTileBigWidget(
      {Key key, this.name, this.image, this.rating, this.genre, this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 330.0,
              width: 245.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      image,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(30)),
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
        ),
        SizedBox(
            width: 220,
            child: Text(name).text.xl.bold.white.make().pOnly(bottom: 10)),
        SizedBox(
          width: 220,
          child: Text(
            genre.join(', '),
            style: TextStyle(color: kColorWhite.withOpacity(0.7)),
          ).pOnly(bottom: 10),
        ),
        HStack([
          Icon(
            Icons.star,
            color: kColorRed,
          ),
          Text(
            '${rating} (${reviews} Reviews)',
            style: TextStyle(color: kColorWhite.withOpacity(0.7)),
          )
        ])
      ],
    ));
  }
}
