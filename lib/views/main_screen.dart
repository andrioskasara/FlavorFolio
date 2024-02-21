import 'package:flavor_folio/utils/colors.dart';
import 'package:flavor_folio/widgets/big_text.dart';
import 'package:flavor_folio/widgets/food_body.dart';
import 'package:flavor_folio/widgets/small_text.dart';
import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "FlavorFolio", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(
                            text: "User",
                            color: Colors.black54,
                          ),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                      child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor),
                    child: Icon(Icons.search,
                        color: AppColors.buttonBgColor,
                        size: Dimensions.iconSize24),
                  ))
                ],
              ),
            ),
          ),
          FoodBody(),
        ],
      ),
    );
  }
}
//
