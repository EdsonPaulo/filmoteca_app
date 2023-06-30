import 'package:filmoteca_app/screens/explore/explore_bloc.dart';
import 'package:filmoteca_app/shared/widgets/filter_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/models/filter_model.dart';
import 'package:get_it/get_it.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreen createState() => _FilterScreen();
}

class _FilterScreen extends State<FilterScreen> {
  ExploreBloc exploreBloc = GetIt.instance<ExploreBloc>();

  final List<FilterModel> _categories = [
    FilterModel(id: "-1", name: 'Tudo', type: FilterType.category),
    ...getCategories().map(
        (e) => FilterModel(id: e.id, name: e.name, type: FilterType.category))
  ];

  final List<FilterModel> _orderList = [
    FilterModel(
        type: FilterType.sort, name: 'Popularidade', id: 'popularity.desc'),
    FilterModel(
        type: FilterType.sort, name: 'Lançamento', id: 'release_date.desc'),
    FilterModel(
        type: FilterType.sort, name: 'Avaliação', id: 'vote_average.desc'),
    FilterModel(type: FilterType.sort, name: 'Votos', id: 'vote_count.desc'),
    FilterModel(
        type: FilterType.sort,
        name: 'Ordem Alfabética A-Z',
        id: 'original_title.asc'),
    FilterModel(
        type: FilterType.sort,
        name: 'Ordem Alfabética Z-A',
        id: 'original_title.desc'),
  ];

  final List<FilterModel> _releaseYears = [
    FilterModel(type: FilterType.release, name: '2023', id: '2023'),
    FilterModel(type: FilterType.release, name: '2022', id: '2022'),
    FilterModel(type: FilterType.release, name: '2021', id: '2021'),
    FilterModel(type: FilterType.release, name: '2020', id: '2020'),
    FilterModel(type: FilterType.release, name: '2019', id: '2019'),
    FilterModel(type: FilterType.release, name: '<2018', id: '<2018'),
  ];

  final List<FilterModel> _regions = [
    FilterModel(type: FilterType.region, name: "Estados Unidos", id: "US"),
    FilterModel(type: FilterType.region, name: "Coreia do Sul", id: "KR"),
    FilterModel(type: FilterType.region, name: "Espanha", id: "ES"),
    FilterModel(type: FilterType.region, name: "França", id: "FR"),
    FilterModel(type: FilterType.region, name: "Brasil", id: "BR"),
    FilterModel(type: FilterType.region, name: "Alemanha", id: "DE"),
    FilterModel(type: FilterType.region, name: "Japão", id: "JP"),
    FilterModel(type: FilterType.region, name: "Índia", id: "IN"),
    FilterModel(type: FilterType.region, name: "Reino Unido", id: "GB"),
    FilterModel(type: FilterType.region, name: "Itália", id: "IT"),
    FilterModel(type: FilterType.region, name: "Nigéria", id: "NG")
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _renderTitle(String label) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          const SizedBox(height: 35),
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.darkPrimaryColor,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.darkPrimaryColor,
      body: StreamBuilder<List<FilterModel>>(
        initialData: const [],
        stream: exploreBloc.filterStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FilterModel> selectedFilters = snapshot.data!;
            return Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: const Text(
                    'Filtros',
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderTitle('Categorias'),
                    FilterHorizontalList(
                      items: _categories,
                      key: const Key('categorias'),
                      variant: FilterListVariantType.outlined,
                      selectedItems: selectedFilters,
                      onPressed: (item, idx) {
                        exploreBloc.updateFilters(item);
                      },
                    ),
                    _renderTitle('Ordenação'),
                    FilterHorizontalList(
                      items: _orderList,
                      variant: FilterListVariantType.outlined,
                      selectedItems: selectedFilters,
                      onPressed: (item, idx) {
                        exploreBloc.updateFilters(item);
                      },
                    ),
                    _renderTitle('Ano de Lançamento'),
                    FilterHorizontalList(
                      items: _releaseYears,
                      variant: FilterListVariantType.outlined,
                      selectedItems: selectedFilters,
                      onPressed: (item, idx) {
                        exploreBloc.updateFilters(item);
                      },
                    ),
                    _renderTitle('Região'),
                    FilterHorizontalList(
                      items: _regions,
                      variant: FilterListVariantType.outlined,
                      selectedItems: selectedFilters,
                      onPressed: (item, idx) {
                        exploreBloc.updateFilters(item);
                      },
                    ),
                  ],
                )
              ],
            );
          }
          return const SizedBox(height: 40);
        },
      ),
    );
  }
}
