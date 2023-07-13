import 'package:filmoteca_app/screens/auth/auth_check_screen.dart';
import 'package:filmoteca_app/screens/auth/authentication_bloc.dart';
import 'package:filmoteca_app/screens/explore/explore_bloc.dart';
import 'package:filmoteca_app/screens/profile/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:filmoteca_app/screens/welcome/onboarding_screen.dart';
import 'package:filmoteca_app/screens/welcome/welcome_screen.dart';
import 'package:filmoteca_app/screens/auth/login_screen.dart';
import 'package:filmoteca_app/screens/auth/register_screen.dart';
import 'package:filmoteca_app/screens/home/home_screen.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/app_bottom_tabs.dart';
import 'package:filmoteca_app/screens/categories/categories_screen.dart';
import 'package:filmoteca_app/screens/categories/category_movies_Screen.dart';
import 'package:filmoteca_app/screens/explore/explore_screen.dart';
import 'package:filmoteca_app/screens/favorites/favorites_bloc.dart';
import 'package:filmoteca_app/screens/favorites/favorites_screen.dart';
import 'package:filmoteca_app/screens/explore/filter_screen.dart';
import 'package:filmoteca_app/screens/movie_details/movie_details_screen.dart';
import 'package:filmoteca_app/screens/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt getIt = GetIt.instance;

  getIt.registerSingleton<FavoritesBloc>(FavoritesBloc());
  getIt.registerSingleton<AuthenticationBloc>(AuthenticationBloc());
  getIt.registerSingleton<ExploreBloc>(ExploreBloc());
  runApp(const FilmotecaApp());
}

class FilmotecaApp extends StatefulWidget {
  const FilmotecaApp({super.key});

  @override
  _FilmotecaAppState createState() => _FilmotecaAppState();
}

class _FilmotecaAppState extends State<FilmotecaApp> {
  FavoritesBloc favoritesBloc = GetIt.instance<FavoritesBloc>();
  AuthenticationBloc authBloc = GetIt.instance<AuthenticationBloc>();
  ExploreBloc exploreBloc = GetIt.instance<ExploreBloc>();

  @override
  void initState() {
    super.initState();
    authBloc.getUserDataFromStorage();
    favoritesBloc.fetchDataFromApi();
  }

  @override
  void dispose() {
    favoritesBloc.dispose();
    authBloc.dispose();
    exploreBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Filmoteca',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'RobotoSlab',
        ),
        home: const AuthCheckScreen(),
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/filter': (context) => const FilterScreen(),
          '/language': (context) => const LanguageScreen(),
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
