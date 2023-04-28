import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:filmoteca_app/widgets/shared/custom_appbar.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _categories = getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      appBar: const CustomHomeAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.topCenter,
              child: const Text(
                'Categorias',
                style: TextStyle(
                  fontSize: 36,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (70 * MediaQuery.of(context).devicePixelRatio),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: AppColors.primaryColor,
                    highlightColor: AppColors.primaryColor,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/category_movies',
                        arguments: _categories[index],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryDarkColor,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(_categories[index].imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          capitalizeText(_categories[index].name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
