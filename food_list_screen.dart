import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/food_service.dart';
import 'food_detail_screen.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  late Future<List<Food>> foodsFuture;

  String searchText = '';
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Cereal',
    'Pulse',
    'Vegetable',
    'Fruit',
    'Dairy',
    'Meat',
  ];

  @override
  void initState() {
    super.initState();
    foodsFuture = FoodService.loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Nutrition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔍 Search bar
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search food...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),

            const SizedBox(height: 10),

            // 🧪 Category filter
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((cat) {
                  final bool isSelected = selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // 📋 Food list
            Expanded(
              child: FutureBuilder<List<Food>>(
                future: foodsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}'));
                  }

                  final foods = snapshot.data!
                      .where((food) {
                        final matchSearch = food.name
                            .toLowerCase()
                            .contains(searchText);

                        final matchCategory =
                            selectedCategory == 'All' ||
                                food.category == selectedCategory;

                        return matchSearch && matchCategory;
                      })
                      .toList();

                  if (foods.isEmpty) {
                    return const Center(
                        child: Text('No food found'));
                  }

                  return ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      final food = foods[index];

                      return Card(
                        child: ListTile(
                          title: Text(food.name),
                          subtitle: Text(food.category),
                          trailing: const Icon(
                              Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FoodDetailScreen(food: food),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
