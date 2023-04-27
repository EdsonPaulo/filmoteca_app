import 'package:filmoteca_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];

  categories.add(
      CategoryModel(1, 'ação', 'https://loremflickr.com/320/240/movie,action'));
  categories.add(CategoryModel(
      2, 'animação', 'https://loremflickr.com/320/240/movie,anime'));
  categories.add(CategoryModel(
      3, 'terror', 'https://loremflickr.com/320/240/movie,horror'));
  categories.add(CategoryModel(
      4, 'comédias', 'https://loremflickr.com/320/240/movie,comedy'));
  categories.add(
      CategoryModel(5, 'sci-fi', 'https://loremflickr.com/320/240/movie,sci'));

  return categories;
}
