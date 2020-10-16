import 'dart:convert';

import 'package:greprestaurant/models/food_item.dart';
import 'package:greprestaurant/models/response_result.dart';
import 'package:http/http.dart' as http;

class Api {
  Api._privateConstructor();

  static final Api _instance = Api._privateConstructor();

  factory Api() {
    return _instance;
  }

  Future<List<FoodItem>> fetchFoods() async {
    ResponseResult result = await _makeRequest('http://163.47.9.26/api/foods');
    if (result.success) {
      List dataList = result.data;
      List<FoodItem> foodList = dataList.map((item) => FoodItem.fromJson(item)).toList();
      return foodList;
    } else {
      throw Exception(result.data);
    }
  }
  
  Future<ResponseResult> _makeRequest(url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      print(jsonBody['error']['code']);
      print(jsonBody['data_list']);
      if (jsonBody['error']['code'] == 0) {
        List<dynamic> dataList = jsonBody['data_list'];
        return ResponseResult(success: true, data: dataList);
      } else {
        return ResponseResult(success: false, data: jsonBody['error']['message']);
      }
    } else {
      return ResponseResult(success: false, data: 'เกิดข้อผิดพลาดในการเชื่อมต่อเครือข่าย');
    }
  }
}