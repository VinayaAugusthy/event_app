import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  Future<void> saveUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  Future<void> clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
  }
}
