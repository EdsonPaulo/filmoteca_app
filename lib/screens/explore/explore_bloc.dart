import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:filmoteca_app/models/filter_model.dart';

class ExploreBloc {
  final _filterSubject = BehaviorSubject<List<FilterModel>>();
  Stream<List<FilterModel>> get filterStream => _filterSubject.stream;

  final List<FilterModel> _filterList = [];

  bool hasSelectedFilterType(FilterModel filter) {
    return _filterList
        .any((item) => item.type == filter.type && item.id == filter.id);
  }

  void updateFilters(FilterModel filter) {
    if (hasSelectedFilterType(filter)) {
      _filterList.removeWhere((item) => item.id == filter.id);
    } else {
      _filterList.add(filter);
    }
    _filterSubject.add(List<FilterModel>.from(_filterList));
  }

  void dispose() {
    _filterSubject.close();
  }
}
