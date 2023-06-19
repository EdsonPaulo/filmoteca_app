import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/app_bottom_tabs.dart';
import 'package:filmoteca_app/screens/categories/categories_screen.dart';
import 'package:filmoteca_app/screens/categories/category_movies_Screen.dart';
import 'package:filmoteca_app/screens/explore/explore_screen.dart';
import 'package:filmoteca_app/screens/favorites/favorites_screen.dart';
import 'package:filmoteca_app/screens/explore/filter_screen.dart';
import 'package:filmoteca_app/screens/movie_details/movie_details_screen.dart';
import 'package:filmoteca_app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:filmoteca_app/screens/welcome/onboarding_screen.dart';
import 'package:filmoteca_app/screens/welcome/splash_screen.dart';
import 'package:filmoteca_app/screens/welcome/welcome_screen.dart';
import 'package:filmoteca_app/screens/auth/login_screen.dart';
import 'package:filmoteca_app/screens/auth/register_screen.dart';
import 'package:filmoteca_app/screens/home/home_screen.dart';

void main() {
  runApp(const FilmotecaApp());
}

class FilmotecaApp extends StatelessWidget {
  const FilmotecaApp({super.key});

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
          '/filter': (context) => const FilterScreen(),
          '/home': (context) => AppBottomTabsScreen(
                children: const [
                  HomeScreen(),
                  CategoriesScreen(),
                  ExploreScreen(),
                  FavoritesScreen(),
                  ProfileScreen()
                ],
              ),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/category_movies') {
            final CategoryModel category = settings.arguments as CategoryModel;
            return MaterialPageRoute(
              builder: (context) => CategoryMoviesScreen(category: category),
            );
          }

          if (settings.name == '/movie_details') {
            final MovieModel movie = settings.arguments as MovieModel;
            return MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movie: movie),
            );
          }
          return null;
        },
      ),
    );
  }
}
