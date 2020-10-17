import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greprestaurant/main.dart';
import 'package:greprestaurant/models/food_item.dart';
import 'package:greprestaurant/models/food_list.dart';
import 'package:greprestaurant/pages/food_details_page.dart';
import 'package:greprestaurant/services/api.dart';
import 'package:provider/provider.dart';

class FoodListPage extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  //List<FoodItem> _foodList;

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  void fetchFoods() async {
    Api api = Api();
    List<FoodItem> list = await api.fetchFoods();

    setState(() {
      Provider.of<FoodList>(context, listen: false).list.addAll(list);
    });
  }

  void _handleClickListItem(index /*index in foodList*/) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(foodItemIndex: index),
      ),
    );
  }

  Widget _buildDataLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(FoodList foodList) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: foodList.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(8.0),
                elevation: 5.0,
                shadowColor: Colors.black.withOpacity(0.2),
                child: InkWell(
                  onTap: () => _handleClickListItem(index),
                  child: Row(
                    children: <Widget>[
                      Image(
                        width: 80.0,
                        height: 80.0,
                        image: NetworkImage(foodList.list[index].image),
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    foodList.list[index].name,
                                    style: GoogleFonts.prompt(fontSize: 20.0),
                                  ),
                                  Text(
                                    '${foodList.list[index].price.toString()} บาท',
                                    style: GoogleFonts.prompt(fontSize: 15.0),
                                  ),
                                ],
                              ),
                              foodList.list[index].itemCount > 0
                                  ? Text(
                                      'x${foodList.list[index].itemCount.toString()}',
                                      style: GoogleFonts.prompt(
                                        fontSize: 18.0,
                                        color: Colors.green,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 6,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          height: 60.0,
          child: Center(
              child: Text(
            '${foodList.list.fold<int>(0, (sum, foodItem) => sum + foodItem.itemCount).toString()} items'
            ', ${foodList.list.fold<int>(0, (totalPrice, foodItem) => totalPrice + foodItem.itemCount * foodItem.price).toString()} บาท',
            style: GoogleFonts.prompt(
              fontSize: 25.0,
              color: Colors.white,
            ),
          )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: Consumer<FoodList>(builder: (context, foodList, child) {
        return Container(
          child: foodList.list == [] ? _buildDataLoading() : _buildList(foodList),
        );
      }),
    );
  }
}
