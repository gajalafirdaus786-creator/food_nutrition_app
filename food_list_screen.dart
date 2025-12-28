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
  List<Food> allFoods = [];
  List<Food> filteredFoods = [];

  String searchText = '';
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    foodsFuture = FoodService.loadFoods();
  }

  void applyFilter() {
    setState(() {
      filteredFoods = allFoods.where((food) {
        final matchesSearch =
            food.name.toLowerCase().contains(searchText.toLowerCase());
        final matchesCategory =
            selectedCategory == 'All' || food.category == selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Nutrition'),
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

          allFoods = snapshot.data!;
          filteredFoods = filteredFoods.isEmpty ? allFoods : filteredFoods;

          final categories = [
            'All',
            ...{for (var f in allFoods) f.category}
          ];

          return Column(
            children: [
              // 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search food...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    searchText = value;
                    applyFilter();
                  },
                ),
              ),

              // 🧃 Category Filter
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) {
                          selectedCategory = category;
                          applyFilter();
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // 📃 Food List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredFoods.length,
                  itemBuilder: (context, index) {
                    final food = filteredFoods[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(food.name),
                        subtitle: Text(food.category),
                        trailing:
                            const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FoodDetailScreen(food: food),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
