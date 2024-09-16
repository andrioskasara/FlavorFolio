import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/create_recipe_screen.dart';
import 'screens/filter_result_screen.dart';
import 'screens/filter_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'providers/recipe_provider.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/register_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/search_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/user_profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlavorFolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/main', page: () => const MainScreen()),
          GetPage(name: '/filter', page: () => const FilterScreen()),
          GetPage(name: '/filter_results', page: () => const FilterResultScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/register', page: () => RegisterScreen()),
          GetPage(name: '/saved', page: () => const SavedScreen()),
          GetPage(name: '/search', page: () => const SearchScreen()),
          GetPage(name: '/user_profile', page: () => const UserProfileScreen()),
          GetPage(name: '/create_recipe', page: () => const CreateRecipeScreen()),
          GetPage(name: '/recipe_detail', page: () => RecipeDetailScreen(recipe: Get.arguments)),
        ],
      ),
    );
  }
}