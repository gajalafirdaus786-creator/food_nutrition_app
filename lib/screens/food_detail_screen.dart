import 'package:flutter/material.dart';
import '../models/food.dart';

class FoodDetailScreen extends StatefulWidget {
  final Food food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final TextEditingController gramController = TextEditingController();

  double protein = 0;
  double carbs = 0;
  double fiber = 0;
  double fat = 0;
  double calories = 0;

  void calculate() {
    final grams = double.tryParse(gramController.text) ?? 0;

    setState(() {
      protein = grams * widget.food.protein / 100;
      carbs = grams * widget.food.carbs / 100;
      fiber = grams * widget.food.fiber / 100;
      fat = grams * widget.food.fat / 100;
      calories = grams * widget.food.calories / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: gramController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter grams (e.g. 100)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: calculate,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),

            resultRow('Protein', protein),
            resultRow('Carbs', carbs),
            resultRow('Fiber', fiber),
            resultRow('Fat', fat),
            resultRow('Calories', calories),
          ],
        ),
      ),
    );
  }

  Widget resultRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
