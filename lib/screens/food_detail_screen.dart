@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.food.name),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food name
          Text(
            widget.food.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          // Category
          Text(
            widget.food.category,
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          // Gram input
          TextField(
            controller: gramController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter grams',
              hintText: 'e.g. 100',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          // Calculate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: calculate,
              child: const Text('Calculate Nutrition'),
            ),
          ),

          const SizedBox(height: 20),

          // Results
          _nutritionCard('Protein (g)', protein),
          _nutritionCard('Carbs (g)', carbs),
          _nutritionCard('Fiber (g)', fiber),
          _nutritionCard('Fat (g)', fat),
          _nutritionCard('Calories', calories),
        ],
      ),
    ),
  );
}Widget _nutritionCard(String title, double value) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
