import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/recipe.dart';

class FilterResultScreen extends StatelessWidget {
  const FilterResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String category = arguments['category'];
    final double rating = arguments['rating'];

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('recipes').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Recipe> recipes = snapshot.data!.docs
            .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        List<Recipe> filteredRecipes = recipes.where((recipe) {
          return (category == 'All' || recipe.category == category) &&
              recipe.rating >= rating;
        }).toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Filtered Results')),
          body: ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(filteredRecipes[index].imageUrl),
                title: Text(filteredRecipes[index].name),
                onTap: () {
                  Get.toNamed('/recipe_detail', arguments: filteredRecipes[index]);
                },
              );
            },
          ),
        );
      },
    );
  }
}