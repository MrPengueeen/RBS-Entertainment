import 'package:RBS/colors.dart';
import 'package:RBS/custom_icons_icons.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_details_banner.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailsScreen({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  // String description =
  //     'Belle, a village girl, embarks on a journey to save her father from a creature that has locked him in his dungeon. Eventually, she learns that the creature is an enchanted prince who has been cursed.';

  bool seeMore = false;
  bool bigDes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seeMore = widget.movie.description.length > 50;
    bigDes = widget.movie.description.length > 50;
  }

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
                      child: Text(widget.movie.title)
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
                        widget.movie.genre.join(', '),
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
                          Text(widget.movie.released,
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
                              Text(widget.movie.rating.toString(),
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
                    HStack([
                      HStack([
                        VxCircle(
                            radius: 50,
                            child: Icon(
                              CustomIcons.play,
                              color: kColorText,
                            ),
                            backgroundColor: kPrimaryColor,
                            border: Border.all(color: kColorText)),
                        Text('Watch Trailer',
                                style: TextStyle(
                                    color: kColorWhite.withOpacity(0.7)))
                            .text
                            .make()
                            .pOnly(left: 10)
                      ]),
                      HStack([
                        VxCircle(
                            radius: 50,
                            child: Icon(
                              CustomIcons.download,
                              color: kColorText,
                            ),
                            backgroundColor: kPrimaryColor,
                            border: Border.all(color: kColorText)),
                        Text('Download',
                                style: TextStyle(
                                    color: kColorWhite.withOpacity(0.7)))
                            .text
                            .make()
                            .pOnly(left: 10)
                      ]),
                      HStack([
                        VxCircle(
                            radius: 50,
                            child: Icon(
                              CustomIcons.share,
                              color: kColorText,
                            ),
                            backgroundColor: kPrimaryColor,
                            border: Border.all(color: kColorText)),
                        Text('Share',
                                style: TextStyle(
                                    color: kColorWhite.withOpacity(0.7)))
                            .text
                            .make()
                            .pOnly(left: 10)
                      ])
                    ], alignment: MainAxisAlignment.spaceBetween)
                        .pOnly(bottom: 15),
                    Divider(
                      color: kColorWhite.withOpacity(0.4),
                    ).pOnly(bottom: 15),
                    Text('Summary').text.bold.white.make().pOnly(bottom: 10),
                    HStack(
                      [
                        Flexible(
                          child: Text(
                            seeMore
                                ? widget.movie.description.substring(0, 51) +
                                    '...'
                                : widget.movie.description,
                            style: TextStyle(color: kColorText),
                          ),
                        ),
                        bigDes
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    seeMore = !seeMore;
                                  });
                                },
                                child: Text(seeMore ? 'See More' : 'See Less')
                                    .text
                                    .white
                                    .bold
                                    .make()
                                    .pOnly(left: 10),
                              )
                            : Container(),
                      ],
                      crossAlignment: CrossAxisAlignment.end,
                    ).pOnly(bottom: 15),
                    Divider(
                      color: kColorWhite.withOpacity(0.4),
                    ).pOnly(bottom: 15),
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
