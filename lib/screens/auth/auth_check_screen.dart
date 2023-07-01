import 'package:filmoteca_app/models/user_model.dart';
import 'package:filmoteca_app/screens/app_bottom_tabs.dart';
import 'package:filmoteca_app/screens/auth/authentication_bloc.dart';
import 'package:filmoteca_app/screens/categories/categories_screen.dart';
import 'package:filmoteca_app/screens/explore/explore_screen.dart';
import 'package:filmoteca_app/screens/favorites/favorites_screen.dart';
import 'package:filmoteca_app/screens/home/home_screen.dart';
import 'package:filmoteca_app/screens/profile/profile_screen.dart';
import 'package:filmoteca_app/screens/welcome/onboarding_screen.dart';
import 'package:filmoteca_app/screens/welcome/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({Key? key}) : super(key: key);

  @override
  _AuthCheckScreenState createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  final AuthenticationBloc _authBloc = GetIt.instance<AuthenticationBloc>();

  @override
  void initState() {
    super.initState();
    _authBloc.getUserDataFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: _authBloc.userDataStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        print(snapshot.toString());
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return AppBottomTabsScreen(
              children: const [
                HomeScreen(),
                CategoriesScreen(),
                ExploreScreen(),
                FavoritesScreen(),
                ProfileScreen()
              ],
            );
          } else {
            return const OnboardingScreen();
          }
        }
        return const SplashScreen();
      },
    );
  }
}
