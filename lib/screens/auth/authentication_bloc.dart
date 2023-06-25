import 'dart:async';
import 'package:filmoteca_app/models/user_model.dart';

class AuthenticationBloc {
  final _authenticatedController = StreamController<bool>();
  final _userDataController = StreamController<UserModel?>();

  Stream<UserModel?> get userData => _userDataController.stream;
  Stream<bool> get isAuthenticated => _authenticatedController.stream;

  // UserModel? _userData;

  void setUserData(UserModel user) {
    // _userData = user;
    _userDataController.sink.add(user);
    saveUserDataOnStorage(user);
    _authenticatedController.sink.add(true);
  }

  void logout() {
    // _userData = null;
    _userDataController.sink.add(null);
    clearUserDataOnStorage();
    _authenticatedController.sink.add(false);
  }

  void getUserDataFromStorage() async {
    try {
      //get user from shared preferences/sqlite
    } catch (e) {}
  }

  void saveUserDataOnStorage(UserModel user) async {
    try {
      //save user in shared preferences/sqlite
    } catch (e) {}
  }

  void clearUserDataOnStorage() async {
    try {
      //delete user in shared preferences/sqlite
    } catch (e) {}
  }

  void dispose() {
    _authenticatedController.close();
    _userDataController.close();
  }
}
