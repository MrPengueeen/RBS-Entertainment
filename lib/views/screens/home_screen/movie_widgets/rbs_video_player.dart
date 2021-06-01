import 'package:RBS/colors.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MoviePlayer extends StatefulWidget {
  @override
  _MoviePlayerState createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  BetterPlayerController _playerController;
  BetterPlayerDataSource _source;
  bool _showAd = false;

  ///Stream controller which updates on play/pause changes

  StreamController<bool> _isPlaying = StreamController.broadcast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _source = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://vod-progressive.akamaized.net/exp=1615575758~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4394%2F20%2F521973218%2F2439252027.mp4~hmac=6c6c314606f934d7ff8501eba77ab51f06d05245e09d6606d64402a4f9b78b81/vimeo-prod-skyfire-std-us/01/4394/20/521973218/2439252027.mp4",
      subtitles: BetterPlayerSubtitlesSource.single(
          type: BetterPlayerSubtitlesSourceType.network,
          name: 'Dummy Subtitle',
          url:
              "http://167.86.115.146:8099/media/subtitles/Healer/English/Healer_EP_01.srt"),
    );

    _playerController = BetterPlayerController(
      BetterPlayerConfiguration(
        fit: BoxFit.fitWidth,
        //overlay: _buildAdOverlay(),

        routePageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondAnimation, provider) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              var size = MediaQuery.of(context).size;
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: provider,
                    ),
                    _buildAdOverlay(size.width),
                  ],
                ),
              );
            },
          );
        },

        controlsConfiguration: BetterPlayerControlsConfiguration(
          //skipBackIcon: Icons.arrow_ba,

          enableProgressText: true,
          playerTheme: BetterPlayerTheme.material,
          loadingColor: kPrimaryColor,
          loadingWidget: Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
          ),
          controlBarHeight: 55,
          progressBarBackgroundColor: kPrimaryColor,
          controlBarColor: kPrimaryColor,
        ),
        subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
            //backgroundColor: Colors.grey,
            fontSize: 20,
            fontColor: Colors.white),
        fullScreenByDefault: false,
      ),
      betterPlayerDataSource: _source,
    );

    _playerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
        print('VIDEO is paused!');
        _isPlaying.add(false);
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.play) {
        print('VIDEO is playing!');
        _isPlaying.add(true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isPlaying.close();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: _playerController,
            ),
          ),
        ),
        _buildAdOverlay(size.width),
      ],
    );
  }

  Widget _buildAdOverlay(double width) {
    return StreamBuilder<bool>(
        stream: _isPlaying.stream,
        builder: (_, snapshot) {
          bool _playing = snapshot.data ?? true;

          if (_playing) {
            return SizedBox();
          }
          return Positioned(
            bottom: 65,
            right: width * 0.1,
            left: width * 0.1,
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: width * 0.2),
              alignment: Alignment.center,
              height: 100,
              width: width * 0.8,
              color: kColorRed,
              child: Text(
                'Custom Ad Banner',
                style: TextStyle(fontSize: 20, color: kColorWhite),
              ),
            ),
          );
        });
  }
}
