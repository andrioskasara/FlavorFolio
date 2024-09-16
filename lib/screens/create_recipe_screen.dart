import 'package:flutter/material.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  String category = '';
  String imageUrl = '';
  double rating = 0.0;
  List<String> reviews = [];
  List<String> ingredients = [];
  List<String> steps = [];

  void _submitRecipe() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newRecipe = Recipe(
        id: '',
        name: name,
        description: description,
        category: category,
        imageUrl: imageUrl,
        rating: rating,
        reviews: reviews,
        ingredients: ingredients,
        steps: steps,
      );

      try {
        await RecipeService().createRecipe(newRecipe);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recipe created successfully')));
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to create recipe')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (val) => name = val,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (val) => description = val,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a description' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                onChanged: (val) => imageUrl = val,
              ),
              ElevatedButton(
                onPressed: _submitRecipe,
                child: const Text('Save Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
