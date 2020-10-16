import 'package:flutter/material.dart';

class FoodItem {
  String name;
  int price;
  String image;
  int itemCount;

  FoodItem({
    @required this.name,
    @required this.price,
    @required this.image,
    @required this.itemCount,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      itemCount: 0,
    );
  }
}
