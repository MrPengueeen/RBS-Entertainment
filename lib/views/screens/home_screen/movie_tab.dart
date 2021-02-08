import 'package:RBS/colors.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_tile_small.dart';
import 'package:RBS/views/shared_widgets/shared_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieTab extends StatefulWidget {
  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HStack(
              [
                Text('Latest Movies')
                    .text
                    .white
                    .xl2
                    .bold
                    .make()
                    .pOnly(bottom: 20),
                Text('See More').text.white.xl2.bold.make().pOnly(bottom: 20),
              ],
              alignment: MainAxisAlignment.spaceBetween,
            ),
            CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: true,
                viewportFraction: 0.7,
                height: 560,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: [
                MovieTileBigWidget(
                  rating: '4.8',
                  reviews: 36,
                  genre: [
                    'Action',
                    'Adventure',
                    'Thriller',
                    'Lots',
                    'Of',
                    'Genres',
                    'For',
                    'UI',
                    'Test'
                  ],
                  name: 'Beauty And The Beast (2017)',
                  image:
                      'https://posteritati.com/posters/000/000/051/575/beauty-and-the-beast-sm-web.jpg',
                ),
                MovieTileBigWidget(
                  rating: '4.8',
                  reviews: 36,
                  genre: ['Action', 'Adventure', 'Thriller'],
                  name: 'Beauty And The Beast (2017)',
                  image:
                      'https://posteritati.com/posters/000/000/051/575/beauty-and-the-beast-sm-web.jpg',
                ),
              ],
            ),
            HStack(
              [
                Text('Popular Movies')
                    .text
                    .white
                    .xl2
                    .bold
                    .make()
                    .pOnly(bottom: 20),
                Text('See More').text.white.xl2.bold.make().pOnly(bottom: 20),
              ],
              alignment: MainAxisAlignment.spaceBetween,
            ),
            HStack([
              MovieTileSmallWidget(
                  name:
                      'Avengers Infinity (2018) LONG LONG LONG LONG LONG LONG LONG LONG LONG TEXT',
                  image:
                      'https://i.pinimg.com/originals/f9/90/12/f99012184e6ccc9769c02958c15bc38c.jpg'),
              MovieTileSmallWidget(
                  name: 'Avengers Infinity (2018)',
                  image:
                      'https://i.pinimg.com/originals/f9/90/12/f99012184e6ccc9769c02958c15bc38c.jpg'),
              MovieTileSmallWidget(
                  name: 'Avengers Infinity (2018)',
                  image:
                      'https://i.pinimg.com/originals/f9/90/12/f99012184e6ccc9769c02958c15bc38c.jpg'),
              MovieTileSmallWidget(
                  name: 'Avengers Infinity (2018)',
                  image:
                      'https://site.groupe-psa.com/content/uploads/sites/9/2016/12/white-background-2.jpg'),
            ]).scrollHorizontal()
          ],
        ),
      ),
    );
  }
}
