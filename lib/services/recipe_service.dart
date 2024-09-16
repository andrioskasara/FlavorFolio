import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '../models/recipe.dart';

class RecipeService {
  final String apiKey = 'fe1888f12c2942c6b9b354cdf5425421';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Recipe>> fetchRecipes(String query) async {
    final response = await http.get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      return data.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> getSavedRecipes() async {
    try {
      final querySnapshot = await _firestore.collection('saved_recipes').get();
      return querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to load saved recipes: $e');
    }
  }

  Future<void> createRecipe(Recipe recipe) async {
    try {
      await _firestore.collection('saved_recipes').add(recipe.toJson());
    } catch (e) {
      throw Exception('Failed to create recipe: $e');
    }
  }
}