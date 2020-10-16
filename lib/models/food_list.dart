import 'package:flutter/material.dart';
import 'package:greprestaurant/models/food_item.dart';

class FoodList extends ChangeNotifier {
  final List<FoodItem> list = [];

  void changeItemCount(int itemIndex, int itemChange) {
    list[itemIndex].itemCount += itemChange;
    if (list[itemIndex].itemCount < 0) list[itemIndex].itemCount = 0;
    notifyListeners();
  }
}