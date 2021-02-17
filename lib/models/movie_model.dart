class MovieModel {
  int id;
  int menuId;
  List<String> genre;
  String title;
  String duration;
  int year;
  int rating;
  String description;
  String released;
  String trailer;
  String video;
  String poster;

  MovieModel(
      {this.description,
      this.duration,
      this.genre,
      this.id,
      this.rating,
      this.title,
      this.year,
      this.menuId,
      this.released,
      this.trailer,
      this.video,
      this.poster});

  factory MovieModel.fromJson(json) {
    List<String> genreList =
        (json['genre'] as List).map((e) => e['name'].toString()).toList();
    return MovieModel(
        id: json['id'],
        title: json['title'],
        duration: json['duration'],
        menuId: json['menu']['id'],
        genre: genreList,
        year: json['publishing_year'],
        rating: json['rating'],
        description: json['description'],
        released: json['released'],
        trailer: json['trailer_of_reference_movie'] != null
            ? json['trailer_of_reference_movie']['video_url']
            : null,
        video: json['video_url'],
        poster: json['poster']);
  }
}
