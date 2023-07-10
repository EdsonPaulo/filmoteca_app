import 'dart:async';
import 'dart:convert';
import 'package:filmoteca_app/models/user_model.dart';
import 'package:filmoteca_app/shared/constants/shared_preferences_keys.dart';
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
      String? userDataJson = prefs.getString(SharedPreferencesKeys.userData);
      String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);
      if (userDataJson != null) {
        Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
        UserModel userData = UserModel.fromJson(userDataMap);
        if (accessToken != null) {
          userData.accessToken = accessToken;
        }
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
        if (userData.accessToken != null) {
          await prefs.setString(
              SharedPreferencesKeys.accessToken, userData.accessToken!);
        }
        await prefs.setString(SharedPreferencesKeys.userData, userDataJson);
      }
    } catch (e) {
      print(e);
    }
  }

  void clearUserDataOnStorage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(SharedPreferencesKeys.userData);
      await prefs.remove(SharedPreferencesKeys.accessToken);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _userDataController.close();
  }
}
