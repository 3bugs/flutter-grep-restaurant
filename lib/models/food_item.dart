import 'package:flutter/material.dart';

class FoodItem {
  int id;
  String name;
  int price;
  String image;
  int itemCount;

  FoodItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.image,
    @required this.itemCount,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      itemCount: 0,
    );
  }
}
