import 'package:RBS/colors.dart';
import 'package:RBS/models/menu_model.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_tile_small.dart';
import 'package:RBS/views/shared_widgets/shared_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
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
                      Text('Latest Movies')
                          .text
                          .white
                          .xl2
                          .bold
                          .make()
                          .pOnly(bottom: 20),
                      Text('See More')
                          .text
                          .white
                          .xl2
                          .bold
                          .make()
                          .pOnly(bottom: 20),
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                  ),
                  CarouselSlider.builder(
                    itemCount: latestMovies.length,
                    itemBuilder: (_, index, initial) => MovieTileBigWidget(
                      movie: latestMovies[index],
                      rating: latestMovies[index].rating.toString(),
                      genre: latestMovies[index].genre,
                      image: latestMovies[index].poster != null
                          ? latestMovies[index].poster
                          : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                      name: latestMovies[index].title,
                      reviews: 36,
                    ),
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.7,
                      height: 560,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                  ),
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
                      Text('Popular Movies')
                          .text
                          .white
                          .xl2
                          .bold
                          .make()
                          .pOnly(bottom: 20),
                      Text('See More')
                          .text
                          .white
                          .xl2
                          .bold
                          .make()
                          .pOnly(bottom: 20),
                    ],
                    alignment: MainAxisAlignment.spaceBetween,
                  ),
                  HStack(popularMovies
                          .map((e) => MovieTileSmallWidget(
                                movie: e,
                                image: e.poster != null
                                    ? e.poster
                                    : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                                name: e.title,
                              ))
                          .toList())
                      .scrollHorizontal()
                ],
              ),
            ),
    );
  }
}
