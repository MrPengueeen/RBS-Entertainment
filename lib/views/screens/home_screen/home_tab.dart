import 'package:RBS/colors.dart';
import 'package:RBS/models/menu_model.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_tile_small.dart';
import 'package:RBS/views/shared_widgets/shared_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isLoading = true;
  //List<MovieModel> movies = List<MovieModel>();
  List<MovieModel> latestMovies = List<MovieModel>();
  List<MovieModel> popularMovies = List<MovieModel>();
  List<MovieTileBigWidget> slider = List<MovieTileBigWidget>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovies();
  }

  Future<void> getMovies() async {
    getLatestMoviesForAll().then((response) {
      latestMovies = (response['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
      slider = latestMovies
          .map(
            (e) => MovieTileBigWidget(
              movie: e,
              rating: e.rating.toString(),
              genre: e.genre,
              image: e.poster != null
                  ? e.poster
                  : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
              name: e.title,
              reviews: 36,
            ),
          )
          .toList();

      getPopularMoviesForAll().then((response) {
        popularMovies = (response['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .toList();

        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        print(error.toString());
        VxToast.show(context, msg: 'Something Went Wrong!');
      });
    }).catchError((error) {
      print(error.toString());
      VxToast.show(context, msg: 'Something Went Wrong!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: () => getMovies(),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: kPrimaryColor,
                ),
              )
            : Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HStack(
                      [
                        Text('Recently Added',
                            style: TextStyle(
                              fontSize: 17,
                            )).text.white.bold.make().pOnly(bottom: 20),
                        Text('See All',
                            style: TextStyle(
                              fontSize: 13,
                            )).text.white.bold.make().pOnly(bottom: 20),
                      ],
                      alignment: MainAxisAlignment.spaceBetween,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.65,
                            autoPlay: false,
                            aspectRatio: 0.89,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                          ),
                          items: slider,
                        ),
                      ],
                    ),
                    // CarouselSlider.builder(
                    //   itemCount: latestMovies.length,
                    //   itemBuilder: (_, index, initial) => MovieTileBigWidget(
                    //     movie: latestMovies[index],
                    //     rating: latestMovies[index].rating.toString(),
                    //     genre: latestMovies[index].genre,
                    //     image: latestMovies[index].poster != null
                    //         ? latestMovies[index].poster
                    //         : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                    //     name: latestMovies[index].title,
                    //     reviews: 36,
                    //   ),
                    //   options: CarouselOptions(
                    //     scrollDirection: Axis.horizontal,
                    //     initialPage: 0,
                    //     enableInfiniteScroll: true,
                    //     viewportFraction: 0.65,
                    //     height: 470,
                    //     enlargeCenterPage: true,
                    //     enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    //   ),
                    // ),
                    // CarouselSlider(
                    //     options: CarouselOptions(
                    //       scrollDirection: Axis.horizontal,
                    //       initialPage: 0,
                    //       enableInfiniteScroll: false,
                    //       viewportFraction: 0.7,
                    //       height: 560,
                    //       enlargeCenterPage: true,
                    //       enlargeStrategy: CenterPageEnlargeStrategy.height,
                    //     ),
                    // items: latestMovies
                    //     .map((e) => MovieTileBigWidget(
                    //           movie: e,
                    //           rating: e.rating.toString(),
                    //           genre: e.genre,
                    //           image:
                    //               'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                    //           name: e.title,
                    //           reviews: 36,
                    //         ))
                    //     .toList()),
                    HStack(
                      [
                        Text('Popular',
                            style: TextStyle(
                              fontSize: 17,
                            )).text.white.bold.make().pOnly(bottom: 20),
                        Text('See All',
                            style: TextStyle(
                              fontSize: 13,
                            )).text.white.bold.make().pOnly(bottom: 20),
                      ],
                      alignment: MainAxisAlignment.spaceBetween,
                    ),
                    HStack(
                      popularMovies
                          .map((e) => MovieTileSmallWidget(
                                movie: e,
                                image: e.poster != null
                                    ? e.poster
                                    : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                                name: e.title,
                              ))
                          .toList(),
                    ).scrollHorizontal()
                  ],
                ),
              ),
      ),
    );
  }
}
