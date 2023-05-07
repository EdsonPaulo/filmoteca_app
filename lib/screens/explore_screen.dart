import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';

import '../data/category_data.dart';
import '../models/category_model.dart';
import '../models/movie_model.dart';
import '../widgets/shared/filter_horizontal_list.dart';
import '../widgets/shared/movie_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<MovieModel>> _moviesFuture;
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _moviesFuture = fetchMovies('popular');
      _categories = [CategoryModel(id: -1, name: 'Tudo'), ...getCategories()];
    });
  }

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
                      hintStyle: const TextStyle(color: Colors.white70),
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
                    Navigator.of(context).pushNamed('/filter');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FilterHorizontalList(
              items: _categories.map((category) => category.toJson()).toList(),
              variant: FilterListVariantType.filled,
              itemRemovable: true,
              //selectedItemIndex: _selectedCategoryIndex,
              onPressed: (item, idx) {
                //handleSelectCategory(idx);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<MovieModel>>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Ocorreu um erro no carregamento. \n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 24),
                      ),
                    );
                  } else {
                    List<MovieModel> movies = snapshot.data!;
                    return GridView.builder(
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MovieCard(movie: movies[index], showInfo: true);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (150 * MediaQuery.of(context).devicePixelRatio),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
