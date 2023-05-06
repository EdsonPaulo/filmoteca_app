import 'package:filmoteca_app/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPrimaryColor,
      appBar: const CustomHomeAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar por título, ator...',
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.primaryColor),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF2A2D38),
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    //Colocar acção aqui!
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
