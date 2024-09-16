class Recipe {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final List<String> reviews;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image'] ?? '',
      rating: json['rating'] ?? 0.0,
      reviews: List<String>.from(json['reviews'] ?? []),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'image': imageUrl,
      'rating': rating,
      'reviews': reviews,
      'ingredients': ingredients,
      'steps': steps,
    };
  }
}