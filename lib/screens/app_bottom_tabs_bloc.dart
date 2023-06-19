import 'dart:async';

class AppBottomTabsBloc {
  final _selectedTabIndex = StreamController<int>();

  Stream<int> get selectedTabIndex => _selectedTabIndex.stream;

  void updateSelectedTabIndex(int newTabIndex) {
    _selectedTabIndex.sink.add(newTabIndex);
  }

  void dispose() {
    _selectedTabIndex.close();
  }
}
