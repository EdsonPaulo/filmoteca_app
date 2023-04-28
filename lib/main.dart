import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/screens/categories_screen.dart';
import 'package:filmoteca_app/screens/category_movies_Screen.dart';
import 'package:filmoteca_app/screens/explore_screen.dart';
import 'package:filmoteca_app/screens/favorites_screen.dart';
import 'package:filmoteca_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:filmoteca_app/screens/onboarding_screen.dart';
import 'package:filmoteca_app/screens/splash_screen.dart';
import 'package:filmoteca_app/screens/welcome_screen.dart';
import 'package:filmoteca_app/screens/login_screen.dart';
import 'package:filmoteca_app/screens/register_screen.dart';
import 'package:filmoteca_app/screens/home_screen.dart';
import 'package:filmoteca_app/screens/main_tabs_screen.dart';
import 'package:filmoteca_app/utils/navigation_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // status bar wiht light style
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Filmoteca',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'RobotoSlab',
        ),
        home: const SplashScreen(),
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => ChangeNotifierProvider(
                create: (context) => NavigationModel(),
                child: const MainTabsScreen(
                  children: [
                    HomeScreen(),
                    CategoriesScreen(),
                    ExploreScreen(),
                    FavoritesScreen(),
                    ProfileScreen()
                  ],
                ),
              )
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/category_movies') {
            final CategoryModel category = settings.arguments as CategoryModel;
            return MaterialPageRoute(
              builder: (context) => CategoryMoviesScreen(category: category),
            );
          }
          return null;
        },
      ),
    );
  }
}
