import 'package:RBS/colors.dart';
import 'package:RBS/custom_icons_icons.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_details_banner.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nb_utils/nb_utils.dart';

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MovieBannerWidget(movie: widget.movie),
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
                    ).pOnly(bottom: 15),
                    HStack([
                      InkWell(
                        onTap: () {
                          if (widget.movie.trailer != null) {
                            playTrailer();
                          } else {
                            VxToast.show(context,
                                msg: 'No trailers are available for this show');
                          }
                        },
                        child: HStack([
                          VxCircle(
                              radius: size.width / 12.5,
                              child: Icon(
                                CustomIcons.play,
                                color: kColorText,
                              ),
                              backgroundColor: kPrimaryColor,
                              border: Border.all(color: kColorText)),
                          SizedBox(
                            width: 80,
                            child: Text('Watch Trailer',
                                    style: TextStyle(
                                        color: kColorWhite.withOpacity(0.7)))
                                .text
                                .make()
                                .pOnly(left: 10),
                          )
                        ]),
                      ),
                      HStack([
                        VxCircle(
                            radius: size.width / 12.5,
                            child: Icon(
                              CustomIcons.download,
                              color: kColorText,
                            ),
                            backgroundColor: kPrimaryColor,
                            border: Border.all(color: kColorText)),
                        SizedBox(
                          width: 80,
                          child: Text('Download',
                                  style: TextStyle(
                                      color: kColorWhite.withOpacity(0.7)))
                              .text
                              .make()
                              .pOnly(left: 10),
                        )
                      ]),
                      HStack([
                        VxCircle(
                            radius: size.width / 12.5,
                            child: Icon(
                              CustomIcons.share,
                              color: kColorText,
                            ),
                            backgroundColor: kPrimaryColor,
                            border: Border.all(color: kColorText)),
                        SizedBox(
                          width: 80,
                          child: Text('Share',
                                  style: TextStyle(
                                      color: kColorWhite.withOpacity(0.7)))
                              .text
                              .make()
                              .pOnly(left: 10),
                        )
                      ])
                    ], alignment: MainAxisAlignment.spaceEvenly)
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
                        InkWell(
                          onTap: () {
                            setState(() {
                              seeMore = !seeMore;
                            });
                          },
                          child: Text(seeMore ? 'Read More' : 'Read Less')
                              .text
                              .white
                              .bold
                              .make()
                              .pOnly(left: 10),
                        ).visible(bigDes)
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

  playTrailer() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: kPrimaryColor,
            insetPadding: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: YoutubePlayerWidget(url: widget.movie.trailer),
            ),
          );
        });
  }
}
