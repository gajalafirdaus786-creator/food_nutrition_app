import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/food.dart';

class FoodService {
  static Future<List<Food>> loadFoods() async {
    final data = await rootBundle.loadString('assets/foods.json');
    final List<dynamic> jsonResult = json.decode(data);
    return jsonResult.map((e) => Food.fromJson(e)).toList();
  }
}
