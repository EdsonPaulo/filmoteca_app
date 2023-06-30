import 'package:filmoteca_app/models/filter_model.dart';
import 'package:filmoteca_app/screens/explore/explore_bloc.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';

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

  ExploreBloc exploreBloc = GetIt.instance<ExploreBloc>();

  @override
  void initState() {
    super.initState();

    setState(() {
      _moviesFuture = fetchMovies('popular');
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    Navigator.of(context).pushNamed('/filter');
                  },
                ),
              ],
            ),
            StreamBuilder<List<FilterModel>>(
              stream: exploreBloc.filterStream,
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<FilterModel> selectedFilters = snapshot.data!;
                  return Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: FilterHorizontalList(
                        items: selectedFilters,
                        selectedItems: selectedFilters,
                        variant: FilterListVariantType.filled,
                        itemRemovable: true,
                        onPressed: (item, idx) {
                          exploreBloc.updateFilters(item);
                        },
                      ));
                }
                return const SizedBox(height: 0);
              },
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
