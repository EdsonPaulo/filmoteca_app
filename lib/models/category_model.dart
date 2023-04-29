class CategoryModel {
  int id;
  String name;
  String? imageUrl;

  CategoryModel({required this.id, required this.name, this.imageUrl});

  // Transform the Model in a generic JSON object {key: value}
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'imageUrl': imageUrl};
  }
}
