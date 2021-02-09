import 'package:RBS/colors.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_details_banner.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieDetailsScreen extends StatefulWidget {
  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MovieBannerWidget(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text('Beauty And The Beast (2017)')
                          .text
                          .xl2
                          .bold
                          .white
                          .make()
                          .pOnly(bottom: 8),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Action, Adventure, Thriller',
                        style: TextStyle(color: kColorWhite.withOpacity(0.7)),
                      ).text.bold.make().pOnly(bottom: 18),
                    ),
                    Divider(
                      color: kColorWhite.withOpacity(0.4),
                    ),
                    HStack(
                      [
                        VStack([
                          Text('Release Date')
                              .text
                              .bold
                              .white
                              .make()
                              .pOnly(bottom: 8),
                          Text('February 23, 2017',
                                  style: TextStyle(
                                      color: kColorWhite.withOpacity(0.7)))
                              .text
                              .bold
                              .make()
                              .pOnly(bottom: 8),
                        ]),
                        VStack(
                          [
                            HStack([
                              Icon(
                                Icons.star,
                                color: kColorRed,
                                size: 30,
                              ).pOnly(right: 5),
                              Text('4.8',
                                  style: TextStyle(
                                    color: kColorRed,
                                  )).text.xl2.bold.make(),
                            ]),
                            Text('36 Reviews',
                                    style: TextStyle(
                                        color: kColorWhite.withOpacity(0.7)))
                                .text
                                .bold
                                .make()
                                .pOnly(bottom: 11),
                          ],
                        ),
                      ],
                      alignment: MainAxisAlignment.spaceBetween,
                    ),
                    Divider(
                      color: kColorWhite.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
