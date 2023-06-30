enum FilterType { sort, category, release, region }

class FilterModel {
  String id;
  String name;
  FilterType type;

  FilterModel({required this.id, required this.name, required this.type});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'type': type};
  }
}
