//

import 'package:RBS/colors.dart';
import 'package:RBS/custom_icons_icons.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_details_banner.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/rbs_video_player.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/youtube_player_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nb_utils/nb_utils.dart';

class MovieDetailsScreenTest extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailsScreenTest({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenTestState createState() => _MovieDetailsScreenTestState();
}

class _MovieDetailsScreenTestState extends State<MovieDetailsScreenTest> {
  // String description =
  //     'Belle, a village girl, embarks on a journey to save her father from a creature that has locked him in his dungeon. Eventually, she learns that the creature is an enchanted prince who has been cursed.';

  bool seeMore = false;
  bool bigDes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget.movie.description = 'Small Description';
    seeMore = widget.movie.description.length > 50;
    bigDes = widget.movie.description.length > 50;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //MovieBannerWidget(movie: widget.movie),
                MoviePlayer().pOnly(bottom: 50),
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
                      VStack(
                        [
                          HStack(
                            [
                              Text('Release Date')
                                  .text
                                  .bold
                                  .white
                                  .make()
                                  .pOnly(bottom: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: kColorRed,
                                    size: 30,
                                  ).pOnly(right: 5),
                                  Text(widget.movie.rating.toString(),
                                      style: TextStyle(
                                        color: kColorRed,
                                      )).text.xl2.bold.make(),
                                ],
                              ),
                            ],
                            alignment: MainAxisAlignment.spaceBetween,
                          ),
                          HStack(
                            [
                              HStack([
                                Text(widget.movie.released,
                                        style: TextStyle(
                                            color:
                                                kColorWhite.withOpacity(0.7)))
                                    .text
                                    .bold
                                    .make()
                                    .pOnly(bottom: 8),
                              ]),
                              Text('36 Reviews',
                                      style: TextStyle(
                                          color: kColorWhite.withOpacity(0.7)))
                                  .text
                                  .bold
                                  .make()
                                  .pOnly(bottom: 11),
                            ],
                            alignment: MainAxisAlignment.spaceBetween,
                          ),
                        ],
                        crossAlignment: CrossAxisAlignment.stretch,
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
                                  msg:
                                      'No trailers are available for this show');
                            }
                          },
                          child: HStack([
                            VxCircle(
                                radius: size.width / 12.5,
                                child: Icon(
                                  CustomIcons.play,
                                  color: kColorText,
                                  size: (size.width / 12.5) / 2,
                                ),
                                backgroundColor: kPrimaryColor,
                                border: Border.all(color: kColorText)),
                            Flexible(
                              //width: 80,
                              child: Text('Trailer',
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
                                size: (size.width / 12.5) / 2,
                              ),
                              backgroundColor: kPrimaryColor,
                              border: Border.all(color: kColorText)),
                          Flexible(
                            child: Text('Download',
                                    style: TextStyle(
                                        color: kColorWhite.withOpacity(0.7)))
                                .text
                                .make()
                                .pOnly(left: 10),
                          )
                        ]),
                        HStack(
                          [
                            VxCircle(
                                radius: size.width / 12.5,
                                child: Icon(
                                  CustomIcons.share,
                                  color: kColorText,
                                  size: (size.width / 12.5) / 2,
                                ),
                                backgroundColor: kPrimaryColor,
                                border: Border.all(color: kColorText)),
                            Flexible(
                              child: Text('Share',
                                      style: TextStyle(
                                          color: kColorWhite.withOpacity(0.7)))
                                  .text
                                  .make()
                                  .pOnly(left: 10),
                            )
                          ],
                        )
                      ], alignment: MainAxisAlignment.spaceBetween)
                          .pOnly(bottom: 15),
                      Divider(
                        color: kColorWhite.withOpacity(0.4),
                      ).pOnly(bottom: 15),
                      Text('Summary').text.bold.white.make().pOnly(bottom: 10),

                      RichText(
                        //textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: kColorText),
                          text: seeMore
                              ? widget.movie.description.substring(0, 51) +
                                  '...'
                              : widget.movie.description,
                          children: <TextSpan>[
                            TextSpan(
                                text: bigDes
                                    ? seeMore
                                        ? ' Read more'
                                        : ' Read less'
                                    : '',
                                style: TextStyle(
                                    color: kColorWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => setState(() => seeMore = !seeMore)),
                          ],
                        ),
                      ),
                      // HStack(
                      //   [
                      //     Flexible(
                      //       child: Text(
                      //         seeMore
                      //             ? widget.movie.description.substring(0, 51) +
                      //                 '...'
                      //             : widget.movie.description,
                      //         style: TextStyle(color: kColorText),
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           seeMore = !seeMore;
                      //         });
                      //       },
                      //       child: Text(seeMore ? 'Read More' : 'Read Less')
                      //           .text
                      //           .white
                      //           .bold
                      //           .make()
                      //           .pOnly(left: 10),
                      //     ).visible(bigDes)
                      //   ],
                      //   crossAlignment: CrossAxisAlignment.end,
                      // ).pOnly(bottom: 15),
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
