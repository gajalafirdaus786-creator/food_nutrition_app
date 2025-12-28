import 'package:flutter/material.dart';
import 'screens/food_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Nutrition App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FoodListScreen(),
    );
  }
}
