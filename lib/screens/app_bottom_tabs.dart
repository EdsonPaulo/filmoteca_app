import 'package:filmoteca_app/screens/app_bottom_tabs_bloc.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomTabsScreen extends StatelessWidget {
  final List<Widget> children;
  final _appBottomTabsBloc = AppBottomTabsBloc();

  AppBottomTabsScreen({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _appBottomTabsBloc.selectedTabIndex,
      initialData: 0,
      builder: (context, snapshot) {
        final selectedTabIndex = snapshot.data ?? 0;

        return Scaffold(
          body: IndexedStack(index: selectedTabIndex, children: children),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: AppColors.darkSecondaryColor,
                boxShadow: [
                  BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
                ]),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: GNav(
                  rippleColor: Colors.black12,
                  hoverColor: Colors.black12,
                  gap: 4,
                  activeColor: AppColors.primaryColor,
                  iconSize: 20,
                  color: Colors.white60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  duration: const Duration(milliseconds: 300),
                  tabBackgroundColor: const Color.fromARGB(50, 0, 0, 0),
                  selectedIndex: selectedTabIndex,
                  onTabChange: (int selectedIndex) {
                    _appBottomTabsBloc.updateSelectedTabIndex(selectedIndex);
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
      },
    );
  }
}
