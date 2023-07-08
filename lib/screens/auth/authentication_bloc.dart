// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:filmoteca_app/models/user_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc {
  final _userDataController = BehaviorSubject<UserModel?>();
  Stream<UserModel?> get userDataStream => _userDataController.stream;

  void setUserData(UserModel user) {
    _userDataController.add(user);
    saveUserDataOnStorage(user);
  }

  void logout() async {
    clearUserDataOnStorage();
    _userDataController.add(null);
  }

  void getUserDataFromStorage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userDataJson = prefs.getString('userData');
      if (userDataJson != null) {
        Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
        UserModel userData = UserModel.fromJson(userDataMap);
        _userDataController.add(userData);
      } else {
        _userDataController.add(null);
      }
    } catch (e) {
      print(e);
    }
  }

  void saveUserDataOnStorage(UserModel? userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (userData != null) {
        String userDataJson = jsonEncode(userData);
        await prefs.setString('userData', userDataJson);
      }
    } catch (e) {
      print(e);
    }
  }

  void clearUserDataOnStorage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData');
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _userDataController.close();
  }
}
