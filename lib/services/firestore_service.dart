import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveRecipe(Recipe recipe) async {
    await _db.collection('recipes').add(recipe.toJson());
  }

  Future<List<Recipe>> getSavedRecipes() async {
    QuerySnapshot snapshot = await _db.collection('recipes').get();
    return snapshot.docs.map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }
}