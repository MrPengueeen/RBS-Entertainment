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

  MovieModel(
      {this.description,
      this.duration,
      this.genre,
      this.id,
      this.rating,
      this.title,
      this.year,
      this.menuId,
      this.released});

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
        released: json['released']);
  }
}
