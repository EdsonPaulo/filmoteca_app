import 'dart:async';

class ExploreBloc {
  final _exploreController = StreamController<List<Map<String, dynamic>>>();
  StreamSink<List<Map<String, dynamic>>> get _inputExplore =>
      _exploreController.sink;
  Stream<List<Map<String, dynamic>>> get filters => _exploreController.stream;

  final List<Map<String, dynamic>> _filterList = [];

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

  bool isSelectedFilter(int filterId) {
    for (var item in _filterList) {
      if (item['id'] == filterId) {
        return true;
      }
    }
    return false;
  }
}
