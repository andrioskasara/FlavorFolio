import 'package:flavor_folio/repositories/recipe_repository.dart';
import 'package:flutter/foundation.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> _savedRecipes = [];

  List<Recipe> get recipes => _recipes;
  List<Recipe> get savedRecipes => _savedRecipes;

  Future<void> searchRecipes(String query) async {
    _recipes = await RecipeRepository().getRecipes(query);
    notifyListeners();
  }

  void saveRecipe(Recipe recipe) {
    _savedRecipes.add(recipe);
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    _savedRecipes.remove(recipe);
    notifyListeners();
  }
}