import 'package:flutter/material.dart';

import '../data/category_data.dart';
import '../models/category_model.dart';
import '../utils/app_colors.dart';
import '../widgets/shared/filter_horizontal_list.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreen createState() => _FilterScreen();
}

class _FilterScreen extends State<FilterScreen> {
  List<CategoryModel> _categories = [];
  final List<String> _orderList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _categories = [CategoryModel(id: -1, name: 'Tudo'), ...getCategories()];
    });
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
      body: Container(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.topCenter,
              child: const Text(
                'Filtros',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categorias',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                FilterHorizontalList(
                  items:
                      _categories.map((category) => category.toJson()).toList(),
                  variant: FilterListVariantType.outlined,
                  itemRemovable: false,
                  //selectedItemIndex: _selectedCategoryIndex,
                  onPressed: (item, idx) {
                    //handleSelectCategory(idx);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Ordenação',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                FilterHorizontalList(
                  items:
                      _categories.map((category) => category.toJson()).toList(),
                  variant: FilterListVariantType.outlined,
                  itemRemovable: false,
                  //selectedItemIndex: _selectedCategoryIndex,
                  onPressed: (item, idx) {
                    //handleSelectCategory(idx);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Ano de Lançamento',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                FilterHorizontalList(
                  items:
                      _categories.map((category) => category.toJson()).toList(),
                  variant: FilterListVariantType.outlined,
                  itemRemovable: false,
                  //selectedItemIndex: _selectedCategoryIndex,
                  onPressed: (item, idx) {
                    //handleSelectCategory(idx);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Região',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                FilterHorizontalList(
                  items:
                      _categories.map((category) => category.toJson()).toList(),
                  variant: FilterListVariantType.outlined,
                  itemRemovable: false,
                  //selectedItemIndex: _selectedCategoryIndex,
                  onPressed: (item, idx) {
                    //handleSelectCategory(idx);
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
