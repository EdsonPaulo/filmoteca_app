import 'package:filmoteca_app/screens/explore/explore_bloc.dart';
import 'package:filmoteca_app/shared/widgets/filter_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:get_it/get_it.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreen createState() => _FilterScreen();
}

class _FilterScreen extends State<FilterScreen> {
  ExploreBloc exploreBloc = GetIt.instance<ExploreBloc>();

  List<CategoryModel> _categories = [];
  final List<Map<String, dynamic>> _orderList = [
    {"name": 'Popularidade', "id": 'popularity.desc'},
    {"name": 'Lançamento', "id": 'release_date.desc'},
    {"name": 'Avaliação', "id": 'vote_average.desc'},
    {"name": 'Votos', "id": 'vote_count.desc'},
    {"name": 'Ordem Alfabética A-Z', "id": 'original_title.asc'},
    {"name": 'Ordem Alfabética Z-A', "id": 'original_title.desc'},
  ];
  final List<Map<String, dynamic>> _releaseYears = [
    {"name": '2023', "id": '2023'},
    {"name": '2022', "id": '2022'},
    {"name": '2021', "id": '2021'},
    {"name": '2020', "id": '2020'},
    {"name": '2019', "id": '2019'},
    {"name": '<2018', "id": '<2018'},
  ];
  final List<Map<String, dynamic>> _regions = [
    {"name": "Estados Unidos", "id": "US"},
    {"name": "Coreia do Sul", "id": "KR"},
    {"name": "Espanha", "id": "ES"},
    {"name": "França", "id": "FR"},
    {"name": "Brasil", "id": "BR"},
    {"name": "Alemanha", "id": "DE"},
    {"name": "Japão", "id": "JP"},
    {"name": "Índia", "id": "IN"},
    {"name": "Reino Unido", "id": "GB"},
    {"name": "Itália", "id": "IT"},
    {"name": "Nigéria", "id": "NG"}
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _categories = [CategoryModel(id: "-1", name: 'Tudo'), ...getCategories()];
    });
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
      body: Column(
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
                items:
                    _categories.map((category) => category.toJson()).toList(),
                variant: FilterListVariantType.outlined,
                selectedItemIndex: exploreBloc.getCategory(),
                onPressed: (item, idx) {
                  setState(() {
                    exploreBloc.actulizarCategory(item['id']);
                    //exploreBloc.isSelectedFilter(item['id'])
                    // ? exploreBloc.removeFilter(item)
                    //: exploreBloc.addFilter(item);
                    // Atualize o valor do índice selecionado
                    if (!exploreBloc.isSelectedFilter(item['id'])) {
                      exploreBloc.addFilter(item);
                    }
                  });
                  //handleSelectCategory(idx);
                },
              ),
              _renderTitle('Ordenação'),
              FilterHorizontalList(
                items: _orderList,
                variant: FilterListVariantType.outlined,
                selectedItemIndex: exploreBloc.getOrder(),
                onPressed: (item, idx) {
                  //handleSelectCategory(idx);
                  setState(() {
                    exploreBloc.actulizarOrder(item['id']);
                    // Atualize o valor do índice selecionado
                    if (!exploreBloc.isSelectedFilter(item['id'])) {
                      exploreBloc.addFilter(item);
                    }
                  });
                },
              ),
              _renderTitle('Ano de Lançamento'),
              FilterHorizontalList(
                items: _releaseYears,
                variant: FilterListVariantType.outlined,
                selectedItemIndex: exploreBloc.getRealese(),
                onPressed: (item, idx) {
                  //handleSelectCategory(idx);
                  setState(() {
                    exploreBloc.actulizarRealese(item['id']);
                    // Atualize o valor do índice selecionado
                   if (!exploreBloc.isSelectedFilter(item['id'])) {
                      exploreBloc.addFilter(item);
                    }
                  });
                },
              ),
              _renderTitle('Região'),
              FilterHorizontalList(
                items: _regions,
                variant: FilterListVariantType.outlined,
                selectedItemIndex: exploreBloc.getRegion(),
                onPressed: (item, idx) {
                  //handleSelectCategory(idx);
                  setState(() {
                    exploreBloc.actulizarRegion(item['id']);
                    if (!exploreBloc.isSelectedFilter(item['id'])) {
                      exploreBloc.addFilter(item);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
