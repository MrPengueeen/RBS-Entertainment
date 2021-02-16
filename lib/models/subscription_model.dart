class SubscriptionModel {
  int id;
  String name;
  String description;
  String price;
  int screen;
  int downloads;
  int status;

  SubscriptionModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.screen,
    this.downloads,
    this.status,
  });

  factory SubscriptionModel.fromJson(json) {
    return SubscriptionModel(
      description: json['description'],
      downloads: json['download_limit'],
      id: json['id'],
      name: json['name'],
      price: json['price'],
      screen: json['Screen'],
      status: json['status'],
    );
  }
}
