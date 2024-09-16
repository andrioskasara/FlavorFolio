import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}
class _FilterScreenState extends State<FilterScreen> {
  String _selectedCategory = 'All';
  double _selectedRating = 0.0;

  final List<String> _categories = ['All', 'Appetizer', 'Main Course', 'Dessert'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Recipes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedCategory,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            Slider(
              value: _selectedRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: _selectedRating.toString(),
              onChanged: (value) {
                setState(() {
                  _selectedRating = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/filter_result', arguments: {
                  'category': _selectedCategory,
                  'rating': _selectedRating,
                });
              },
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}