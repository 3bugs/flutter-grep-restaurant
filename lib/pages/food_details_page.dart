import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greprestaurant/main.dart';
import 'package:greprestaurant/models/food_item.dart';
import 'package:greprestaurant/models/food_list.dart';
import 'package:provider/provider.dart';

class FoodDetailsPage extends StatefulWidget {
  final int foodItemIndex;

  FoodDetailsPage({@required this.foodItemIndex});

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  void _handleChangeItemCount(int itemChange) {
    FoodList foodList = Provider.of<FoodList>(context, listen: false);
    foodList.changeItemCount(widget.foodItemIndex, itemChange);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodList>(
      builder: (context, foodList, child) {
        FoodItem foodItem = foodList.list[widget.foodItemIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text(APP_NAME),
          ),
          body: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 3 / 2,
                child: Image(
                  image: NetworkImage(foodItem.image),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'ชื่อเมนู: ${foodItem.name}',
                        style: GoogleFonts.prompt(fontSize: 20.0),
                      ),
                      Text(
                        'ราคา: ${foodItem.price.toString()} บาท',
                        style: GoogleFonts.prompt(fontSize: 20.0),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: foodItem.itemCount > 0
                                    ? () => _handleChangeItemCount(-1)
                                    : null,
                                child: const Text('-', style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  foodItem.itemCount.toString(),
                                  style: GoogleFonts.prompt(fontSize: 20.0),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () => _handleChangeItemCount(1),
                                child: const Text('+', style: TextStyle(fontSize: 20)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
