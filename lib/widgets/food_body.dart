import 'package:dots_indicator/dots_indicator.dart';
import 'package:flavor_folio/utils/colors.dart';
import 'package:flavor_folio/utils/dimensions.dart';
import 'package:flavor_folio/widgets/big_text.dart';
import 'package:flavor_folio/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class FoodBody extends StatefulWidget {
  const FoodBody({super.key});

  @override
  State<FoodBody> createState() => _FoodBodyState();
}

class _FoodBodyState extends State<FoodBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: Row(
                children: [BigText(text: "Recommended")],
              ),
            ),
            SizedBox(height: Dimensions.height10),
            SizedBox(
              height: Dimensions.pageView,
              child: PageView.builder(
                controller: pageController,
                itemCount: recipeProvider.recipes.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(context, recipeProvider.recipes[position]);
                },
              ),
            ),
            DotsIndicator(
              dotsCount: recipeProvider.recipes.length,
              position: _currentPageValue.floor(),
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            SizedBox(height: Dimensions.height30),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: Row(
                children: [BigText(text: "Top recipes")],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recipeProvider.savedRecipes.length,
              itemBuilder: (context, index) {
                return _buildRecipeItem(context, recipeProvider.savedRecipes[index]);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPageItem(BuildContext context, Recipe recipe) {
    Matrix4 matrix = Matrix4.identity();
    if (_currentPageValue.floor() == 0) {
      var currentScale = 1 - (_currentPageValue - 0) * (1 - _scaleFactor);
      var currentTranslation = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTranslation, 0);
    } else {
      var currentScale = _scaleFactor;
      var currentTranslation = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTranslation, 0);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/recipe_detail', arguments: recipe);
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.grey[200],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(recipe.imageUrl),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.height15,
                      right: Dimensions.height15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: recipe.name),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                    (index) => const Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 15)),
                          ),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: recipe.rating.toString()),
                          SizedBox(width: Dimensions.width30),
                          SmallText(text: "${recipe.reviews} reviews"),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeItem(BuildContext context, Recipe recipe) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(recipe.imageUrl),
          ),
          title: Text(recipe.name),
          subtitle: Text("${recipe.rating} ★ - ${recipe.reviews} reviews"),
          trailing: IconButton(
            icon: Icon(
              recipeProvider.savedRecipes.contains(recipe)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: recipeProvider.savedRecipes.contains(recipe)
                  ? Colors.red
                  : null,
            ),
            onPressed: () {
              setState(() {
                if (recipeProvider.savedRecipes.contains(recipe)) {
                  recipeProvider.removeRecipe(recipe);
                } else {
                  recipeProvider.saveRecipe(recipe);
                }
              });
            },
          ),
          onTap: () {
            Navigator.pushNamed(context, '/recipe_detail', arguments: recipe);
          },
        );
      },
    );
  }
}
