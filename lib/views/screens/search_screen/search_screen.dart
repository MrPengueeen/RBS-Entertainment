import 'package:RBS/colors.dart';
import 'package:RBS/custom_icons_icons.dart';
import 'package:RBS/models/movie_model.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/home_screen/movie_details_screen.dart';
import 'package:RBS/views/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchTerm = '';
  bool isLoading = false;
  List<MovieModel> result = List<MovieModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        hintText: 'Search for shows...',
                        onChanged: (value) => _searchTerm = value,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          CustomIcons.search,
                          color: kColorWhite,
                        ),
                        onPressed: () async {
                          hideKeyboard(context);
                          if (_searchTerm.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            getMoviesBySearch(_searchTerm).then((value) {
                              print('Response from button : $value');
                              result = ((value['results']) as List).map((e) {
                                print('here');
                                return MovieModel.fromJson(e);
                              }).toList();
                              setState(() {
                                isLoading = false;
                              });
                            }).catchError((error) {
                              VxToast.show(context, msg: error.toString());
                              setState(() {
                                isLoading = false;
                              });
                            });
                          } else {
                            VxToast.show(context,
                                msg: 'Please enter a search term');
                          }
                        }),
                  ],
                ),
                Center(
                  child: SingleChildScrollView(
                    child: isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: kPrimaryColor,
                          )
                        : result.isEmpty
                            ? Center(
                                    child: Text(
                                            'No results found, search for a show')
                                        .text
                                        .white
                                        .make())
                                .pOnly(top: 30)
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: result.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: ListTile(
                                      leading: Image.network(
                                        result[index].poster != null
                                            ? result[index].poster
                                            : 'https://image.freepik.com/free-psd/movie-poster-mockup_1390-698.jpg?1',
                                        fit: BoxFit.fitHeight,
                                      ),
                                      title: Text(result[index].title)
                                          .text
                                          .white
                                          .make(),
                                      onTap: () => pushNewScreen(context,
                                          screen: MovieDetailsScreen(
                                            movie: result[index],
                                          ),
                                          withNavBar: true),
                                    ),
                                  );
                                }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
