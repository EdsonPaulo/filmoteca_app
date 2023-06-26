import 'dart:async';

class ExploreBloc {
  final _exploreController = StreamController<List<Map<String, dynamic>>>();
  StreamSink<List<Map<String, dynamic>>> get _inputExplore =>
      _exploreController.sink;
  Stream<List<Map<String, dynamic>>> get filters => _exploreController.stream;

  final categoryController = StreamController<String>();

  Stream<String> get categoryStream => categoryController.stream;

  final orderController = StreamController<String>();

  Stream<String> get orderStream => orderController.stream;

  final realeseController = StreamController<String>();

  Stream<String> get realeseStream => realeseController.stream;

  final regionController = StreamController<String>();

  Stream<String> get regionStream => regionController.stream;

  late List<Map<String, dynamic>> _filterList = [];
  late String _selectedCategoryIndex;
  late String _selectedOrderIndex;
  late String _selectedRealeseIndex;
  late String _selectedRegionsIndex;

  void initFilters() {
    try {
      _filterList = [
        {"name": 'Popularidade', "id": 'popularity.desc'},
        {"name": 'Familia', "id": '123'}
      ];
      _selectedCategoryIndex = '-1';
      _selectedOrderIndex = 'popularity.desc';
      _selectedRealeseIndex = '2023';
      _selectedRegionsIndex = 'US';

      _inputExplore.add(List<Map<String, dynamic>>.from(_filterList));

      categoryController.sink.add(_selectedCategoryIndex);
      orderController.sink.add(_selectedOrderIndex);
      realeseController.sink.add(_selectedRealeseIndex);
      regionController.sink.add(_selectedRegionsIndex);
    } catch (e) {
      print('initFilters: $e');
    }
  }

//Ctegoria
  void actulizarCategory(String selectedCat) {
    _selectedCategoryIndex = selectedCat;
    categoryController.sink.add(_selectedCategoryIndex);
  }

  String getCategory() {
    return _selectedCategoryIndex;
  }

  //Order
  void actulizarOrder(String selected) {
    _selectedOrderIndex = selected;
    orderController.sink.add(_selectedOrderIndex);
  }

  String getOrder() {
    return _selectedOrderIndex;
  }

  //realese
  void actulizarRealese(String selected) {
    _selectedRealeseIndex = selected;
    realeseController.sink.add(_selectedRealeseIndex);
  }

  String getRealese() {
    return _selectedRealeseIndex;
  }

  //Region
  void actulizarRegion(String selected) {
    _selectedRegionsIndex = selected;
    regionController.sink.add(_selectedRegionsIndex);
  }

  String getRegion() {
    return _selectedRegionsIndex;
  }

  ///////////////////////////////

  void addFilter(Map<String, dynamic> filter) {
    if (!isSelectedFilter(filter['id'])) {
      _filterList.add(filter);
      _inputExplore.add(List<Map<String, dynamic>>.from(_filterList));
    }
  }

  void removeFilter(Map<String, dynamic> filter) {
    _filterList.removeWhere((element) => element['id'] == filter['id']);
    _inputExplore.add(List<Map<String, dynamic>>.from(_filterList));
  }

  bool isSelectedFilter(String filterId) {
    for (var item in _filterList) {
      if (item['id'] == filterId) {
        return true;
      }
    }
    return false;
  }

  void dispose() {
    _exploreController.close();
    categoryController.close();
  }
}
