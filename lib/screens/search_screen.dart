import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    Provider.of<RecipeProvider>(context, listen: false)
        .searchRecipes(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for recipes...',
              ),
              onSubmitted: (_) => _onSearch(),
            ),
          ),
          Expanded(
            child: Consumer<RecipeProvider>(
              builder: (context, recipeProvider, child) {
                return ListView.builder(
                  itemCount: recipeProvider.recipes.length,
                  itemBuilder: (context, index) {
                    return RecipeListItem(
                      recipe: recipeProvider.recipes[index],
                      onTap: () {
                        // Navigate to recipe detail page
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}