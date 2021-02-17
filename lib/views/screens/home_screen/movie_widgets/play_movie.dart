import 'package:RBS/colors.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class PlayMovieScreen extends StatefulWidget {
  final url;

  const PlayMovieScreen({Key key, this.url}) : super(key: key);

  @override
  _PlayMovieScreenState createState() => _PlayMovieScreenState();
}

class _PlayMovieScreenState extends State<PlayMovieScreen> {
  Future<void> disableScreenRecord() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    // disableScreenRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: YoutubePlayerWidget(url: widget.url)),
        ],
      ),
    );
  }
}
