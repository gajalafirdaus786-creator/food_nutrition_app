class Food {
  final String name;
  final String category;
  final double protein;
  final double carbs;
  final double fiber;
  final double fat;
  final double calories;

  Food({
    required this.name,
    required this.category,
    required this.protein,
    required this.carbs,
    required this.fiber,
    required this.fat,
    required this.calories,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      category: json['category'],
      protein: (json['protein']).toDouble(),
      carbs: (json['carbs']).toDouble(),
      fiber: (json['fiber']).toDouble(),
      fat: (json['fat']).toDouble(),
      calories: (json['calories']).toDouble(),
    );
  }
}
