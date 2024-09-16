import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeListItem({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(recipe.name),
      subtitle: Text(recipe.description),
      onTap: onTap,
    );
  }
}