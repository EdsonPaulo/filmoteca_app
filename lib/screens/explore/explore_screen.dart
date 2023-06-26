import 'package:filmoteca_app/screens/explore/explore_bloc.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';

import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/shared/widgets/custom_appbar.dart';
import 'package:filmoteca_app/shared/widgets/movie_card.dart';
import 'package:filmoteca_app/shared/widgets/filter_horizontal_list.dart';
import 'package:get_it/get_it.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<MovieModel>> _moviesFuture;
  List<CategoryModel> _categories = [];

  ExploreBloc exploreBloc = GetIt.instance<ExploreBloc>();

  @override
  void initState() {
    super.initState();

    setState(() {
      _moviesFuture = fetchMovies('popular');
      _categories = [CategoryModel(id: "-1", name: 'Tudo'), ...getCategories()];
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
            SizedBox(
              height: 35,
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: exploreBloc.filters,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> filter = snapshot.data!;
                    return FilterHorizontalList(
                      items: filter,
                      variant: FilterListVariantType.filled,
                      itemRemovable: true,
                      //selectedItemIndex: _selectedCategoryIndex,
                      onPressed: (item, idx) {
                        //handleSelectCategory(idx);
                        setState(() {
                          exploreBloc.isSelectedFilter(item['id'])
                              ? exploreBloc.removeFilter(item)
                              : exploreBloc.addFilter(item);
                        });
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Erro ao processar os filtros',
                      style: TextStyle(color: Colors.redAccent, fontSize: 16),
                    );
                  }
                  return const Text('Processando filtros');
                },
              ),
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
