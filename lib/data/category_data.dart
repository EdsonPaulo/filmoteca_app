import 'package:filmoteca_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];

  categories.add(CategoryModel(
      id: 1,
      name: 'ação',
      imageUrl: 'https://loremflickr.com/320/240/movie,action'));
  categories.add(CategoryModel(
      id: 2,
      name: 'animação',
      imageUrl: 'https://loremflickr.com/320/240/movie,anime'));
  categories.add(CategoryModel(
      id: 3,
      name: 'terror',
      imageUrl: 'https://loremflickr.com/320/240/movie,horror'));
  categories.add(CategoryModel(
      id: 4,
      name: 'comédias',
      imageUrl: 'https://loremflickr.com/320/240/movie,comedy'));
  categories.add(CategoryModel(
      id: 5,
      name: 'sci-fi',
      imageUrl: 'https://loremflickr.com/320/240/movie,sci'));

  return categories;
}
