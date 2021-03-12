import 'package:RBS/colors.dart';
import 'package:RBS/models/menu_model.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_tile.dart';
import 'package:RBS/views/screens/home_screen/movie_widgets/movie_tile_small.dart';
import 'package:RBS/views/shared_widgets/shared_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nb_utils/nb_utils.dart';

class MovieTab extends StatefulWidget {
  final MenuModel menu;

  const MovieTab({Key key, this.menu}) : super(key: key);

  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isLoading = true;
  List<MovieModel> movies = List<MovieModel>();
  List<MovieModel> latestMovies = List<MovieModel>();
  //List<MovieModel> popularMovies = List<MovieModel>();
  int _page = 1;
  int _perPage = 2;
  int _next;
  bool _newLoading = false;
  ScrollController _sccontroller = new ScrollController();
  bool _alreadyApi = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMovies();
  }

  @override
  void dispose() {
    _sccontroller.dispose();
    super.dispose();
  }

  Future<void> getMovies() async {
    getLatestMoviesByMenu(widget.menu.id).then((response) {
      latestMovies = (response['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();

      _page = 1;

      getMoviesByMenu(widget.menu.id, _page, _perPage).then((response) {
        movies = (response['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .toList();
        _next = response['next'];

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
    var size = MediaQuery.of(context).size;
    return NotificationListener(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
          //print('Scroll End notification listener');
          setState(() {
            _newLoading = _next != null ? true : false;
          });
          if (_next != null && _alreadyApi == false) {
            setState(() {
              _alreadyApi = true;
            });
            _page += 1;

            getMoviesByMenu(widget.menu.id, _page, _perPage).then((response) {
              movies.addAll((response['results'] as List)
                  .map((e) => MovieModel.fromJson(e)));
              _next = response['next'];
              _alreadyApi = false;
              setState(() {});
            }).catchError((error) {
              VxToast.show(context, msg: error.toString());
              setState(() {
                _newLoading = false;
              });
            });
          }
        }
        return false;
      },
      child: RefreshIndicator(
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
                          enableInfiniteScroll: true,
                          viewportFraction: 0.65,
                          height: 470,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        ),
                      ),
                      HStack(
                        [
                          Text('All ${widget.menu.title}',
                              style: TextStyle(
                                fontSize: 17,
                              )).text.white.bold.make().pOnly(bottom: 20),
                          // Text('See All',
                          //     style: TextStyle(
                          //       fontSize: 13,
                          //     )).text.white.bold.make().pOnly(bottom: 20),
                        ],
                        alignment: MainAxisAlignment.spaceBetween,
                      ),
                      Center(
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: (size.width * 0.4) /
                                        ((size.width * 0.4) + 50),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0),
                            itemCount: movies.length,
                            //controller: _sccontroller,
                            itemBuilder: (_, index) {
                              return MovieTileWidget(
                                movie: movies[index],
                                image: movies[index].poster != null
                                    ? movies[index].poster
                                    : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                                name: movies[index].title,
                              );
                            }),
                      ),
                      CircularProgressIndicator(backgroundColor: kColorWhite)
                          .visible(_newLoading)
                          .centered()
                          .pSymmetric(v: 20)
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
