import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/food_service.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  late Future<List<Food>> foodsFuture;

  @override
  void initState() {
    super.initState();
    foodsFuture = FoodService.loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Food'),
      ),
      body: FutureBuilder<List<Food>>(
        future: foodsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final foods = snapshot.data!;

          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return ListTile(
                title: Text(food.name),
                subtitle: Text(food.category),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // next screen later
                },
              );
            },
          );
        },
      ),
    );
  }
}
