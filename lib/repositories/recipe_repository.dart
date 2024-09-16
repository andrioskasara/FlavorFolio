import '../services/recipe_service.dart';
import '../models/recipe.dart';

class RecipeRepository {
  final RecipeService _recipeService = RecipeService();

  Future<List<Recipe>> getRecipes(String query) async {
    return await _recipeService.fetchRecipes(query);
  }

  Future<List<Recipe>> getSavedRecipes() async {
    return await _recipeService.getSavedRecipes();
  }
}