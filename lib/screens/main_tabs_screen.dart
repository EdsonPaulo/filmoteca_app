import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/navigation_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MainTabsScreen extends StatelessWidget {
  final List<Widget> children;

  const MainTabsScreen({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);

    return Scaffold(
      body: IndexedStack(
        index: navigationModel.selectedIndex,
        children: children,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: AppColors.secondaryDarkColor,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: GNav(
              rippleColor: Colors.black12,
              hoverColor: Colors.black12,
              gap: 4,
              activeColor: AppColors.primaryColor,
              iconSize: 20,
              color: Colors.white60,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              duration: const Duration(milliseconds: 300),
              tabBackgroundColor: const Color.fromARGB(50, 0, 0, 0),
              selectedIndex: navigationModel.selectedIndex,
              onTabChange: (int selectedIndex) {
                navigationModel.updateSelectedIndex(selectedIndex);
              },
              tabs: const [
                GButton(
                  icon: CupertinoIcons.house_alt,
                  text: 'Início',
                ),
                GButton(
                  icon: CupertinoIcons.rectangle_grid_2x2,
                  text: 'Categorias',
                ),
                GButton(
                  icon: CupertinoIcons.search,
                  text: 'Explorar',
                ),
                GButton(
                  icon: CupertinoIcons.heart,
                  text: 'Favoritos',
                ),
                GButton(
                  icon: CupertinoIcons.person,
                  text: 'Perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
