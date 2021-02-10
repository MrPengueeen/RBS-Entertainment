import 'package:flutter/cupertino.dart';

class MenuModel {
  int id;
  String title;

  MenuModel({this.id, this.title});
  factory MenuModel.fromJson(json) {
    return MenuModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
