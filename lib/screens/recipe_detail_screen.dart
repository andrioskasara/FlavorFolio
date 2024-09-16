import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(recipe.description),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Ingredients:'),
            ),
            ...recipe.ingredients.map((ingredient) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('- $ingredient'),
            )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Steps:'),
            ),
            ...recipe.steps.map((step) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('- $step'),
            )),
          ],
        ),
      ),
    );
  }
}